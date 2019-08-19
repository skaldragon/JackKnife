<# With the help of people from Reddit and the main user /u/ka-splam,
this project couldn't have been fixed without them and couldn't have made this tool better. Thanks! #>

function Get-ProcessExplorer {

    [CmdletBinding()]
    param(
        [Parameter()][string]$SigCheckPath
    )
<#
    .SYNOPSIS
        This function has the capability to gather a bunch of process information off remote or local systems.
    .PARAMETER $RunningProcesses
        Unless you state the value of this Parameter it will become defaulf all proecess IDs of running processes you create. If you want a specific Process ID state the value of that Process ID. 
    .PARAMETER Switch $SignedAndExecutableType
        Uses sigcheck.exe from SysInternalsSuite to get the verified signature of the executables and the relative 32 or 64 bit type of the process. MUST have sysinternals sigcheck.exe installed on your local system for it to work. 
    .EXAMPLE
     Get-ProcessExplorer -SignedAndExecutableType
     .INPUTS
    This function does not accept pipeline input.
    .OUTPUTS
    Can be Exported to CSV or Normal Text files, but highly recommend CSV format at the layout looks better.
#>
    
    if ($PSBoundParameters.ContainsKey('SigCheckPath'))
    {
        $SigCheckPath = Join-Path -Path $SigCheckPath -ChildPath 'sigcheck.exe'
    }


    # Running Elevated to get usernames?
    $isElevated = [Security.Principal.WindowsPrincipal]::new(
                       [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
                          [Security.Principal.WindowsBuiltInRole]::Administrator)


    if ($isElevated)
    {
        $procs = Get-Process -IncludeUserName | 
                    Group-Object -Property Id -AsHashTable
    }


    $childProcessLookup = ($cimProcs = Get-CimInstance -ClassName Win32_Process) | 
                            Group-Object -Property ParentProcessID -AsHashTable

    $nl = [Environment]::NewLine

    # Process each Process
    foreach ($p in $cimProcs)
    {
        $childProcs = $childProcessLookup[$p.ProcessId]

        $data = @{
            ProcessName = $p.ProcessName
            ProcessID   = $p.ProcessId
            CommandLine = $p.CommandLine
            Path        = $p.Path
            ChildProcess     = [string]::Join($nl, @($childProcs.Processname))
            ChildProcessID   = [string]::Join($nl, @($childProcs.ProcessID))
            ChildCommandLine = [string]::Join($nl, @($childProcs.commandline))
            ChildPath        = [string]::Join($nl, @($childProcs.path))
            StartTime    = $p.CreationDate
        }

        if ($isElevated)
        {
            $data['UserName'] = $procs[[int]$p.ProcessId].UserName
        }

        if ($SigCheckPath)
        { 
            $sigLines = & $SigCheckPath $p.ExecutablePath -accepteula

            $data['Verified Signer'] = [string]::Join($nl, ($sigLines -like '*Publisher*'))
            $data['Executable Type'] = [string]::Join($nl, ($sigLines -like '*MachineType*'))
        }

        [PsCustomObject]$data
    }

   
}#End Get-ProcessExplorer
