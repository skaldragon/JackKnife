function Get-ProcessExplorer{
param(
[Parameter()]$RunningProcesses=(Get-WmiObject win32_process | select processid).processid,
[Parameter()][switch]$SignedAndExecutableType
)

<#
	.SYNOPSIS
		This function has the capability to gather a bunch of process information off remote or local systems.
	.PARAMETER $RunningProcesses
		Unless you state the value of this Parameter it will become defaulf all proecess IDs of running processes you create. If you want a specific Process ID state the value of 		that Process ID. 
	.PARAMETER Switch $SignedAndExecutableType
		Uses sigcheck.exe from SysInternalsSuite to get the verified signature of the executables and the relative 32 or 64 bit type of the process. MUST have sysinternals 				sigcheck.exe installed on your local system for it to work. 
	.EXAMPLE
	 Get-ProcessExplorer -SignedAndExecutableType
	 .INPUTS
	This function does not accept pipeline input.
	.OUTPUTS
	Can be Exported to CSV or Normal Text files, but highly recommend CSV format at the layout looks better.
		#>
if($SignedAndExecutableType){
$chosenpath=Read-Host " Where is the path for your sigcheck.exe"; cd $chosenpath
foreach($ID in $RunningProcesses){
Get-WmiObject win32_process | Where-Object{$_.processid -eq "$ID"}| Select ProcessName,ProcessID,CommandLine,Path,
@{Name="ChildProcess";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select processname).Processname) -join "`n"}}
@{Name="ChildProcessID";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select ProcessID).ProcessID) -join "`n"}}
@{Name="ChildCommandLine";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select commandline).commandline) -join "`n"}}
@{Name="ChildPath";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select path).path) -join "`n"}}
@{Name="UserName";Expression={((Get-process -IncludeUserName|Where-Object{$_.id -eq "$ID"} | select username).username) -join "`n"}}
@{Name="Verified Signer";Expression={($processpath=(Get-WmiObject win32_process | Where-Object{$_.processid -eq "$ID"} Select Executablepath).Executablepath); (.\sigcheck.exe $processpath -accepteula | select-string -Pattern "Publisher") -join "`n"}},
@{Name="Executable Type";Expression={($processpath=(Get-WmiObject win32_process | Where-Object{$_.processid -eq "$ID"} Select Executablepath).Executablepath); (.\sigcheck.exe $processpath -accepteula | select-string -Pattern "MachineType") -join "`n"}},
@{Name="Start Time";Expression={((Get-Process | Where-Object{$_.id -eq "$ID"} | select Starttime).StartTime) -join "`n"}}


}
}#End Signed



else{
foreach($ID in $RunningProcesses){
Get-WmiObject win32_process | Where-Object{$_.processid -eq "$ID"}| Select ProcessName,ProcessID,CommandLine,Path,
@{Name="ChildProcess";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select processname).Processname) -join "`n"}}
@{Name="ChildProcessID";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select ProcessID).ProcessID) -join "`n"}}
@{Name="ChildCommandLine";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select commandline).commandline) -join "`n"}}
@{Name="ChildPath";Expression={((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select path).path) -join "`n"}}
@{Name="UserName";Expression={((Get-process -IncludeUserName|Where-Object{$_.id -eq "$ID"} | select username).username) -join "`n"}},
@{Name="Start Time";Expression={((Get-Process | Where-Object{$_.id -eq "$ID"} | select Starttime).StartTime) -join "`n"}}

}

}#End else
}#End Get-ProcessExplorer