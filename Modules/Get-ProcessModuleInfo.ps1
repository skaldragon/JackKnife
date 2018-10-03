function Get-ProcessModuleInfo
{
param(
[parameter(Mandatory =$true)][string]$Processname,
[parameter(Mandatory =$true)][string]$Filepath
)

    if(Get-Process -Name $Processname){
    $Modules=(get-process -Name $Processname -Module | select modulename).modulename
    }
        else{
        Write-Host "Process doesn't exist try again" -ForegroundColor Red
        }
foreach($item in $Modules){
$exe=Get-WmiObject -Namespace root\cimv2 -Class cim_processexecutable | ?{$_.antecedent -match "$item"}
        foreach($item2 in $exe){
        [wmi]"$($item2.Antecedent)" | select FileName,Extension,Manufacturer,Version |Sort-Object filename -Unique | Export-Csv -Path $Filepath -Append

                               }
                            }
}