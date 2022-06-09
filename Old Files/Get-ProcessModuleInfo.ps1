function Get-ProcessModuleInfo {
#This Functions is to get Information about the modules loaded into running processes
param(
[parameter(Mandatory =$true)][string]$Processname,
[parameter(Mandatory =$true)][string]$Filepath,
[parameter(Mandatory =$false)][switch]$nonproprietary

)
if(!$nonproprietary){
    if(Get-Process -Name $Processname){
    $Modules=(get-process -Name $Processname -Module | select modulename | sort modulename -Unique).modulename
    }
        else{
        Write-Host "Process doesn't exist try again" -ForegroundColor Red
        }
foreach($item in $Modules){
$exe=Get-WmiObject -Namespace root\cimv2 -Class cim_processexecutable | ?{$_.antecedent -match "$item"} | Sort-Object antecedent -Unique
        foreach($item2 in $exe){
        [wmi]"$($item2.Antecedent)" | select FileName,Extension,Manufacturer,Version | Export-Csv -Path $Filepath -Append
                               }
                            }

                    }


if($nonproprietary){
if(Get-Process -Name $Processname){
    $Modules=(get-process -Name $Processname -Module | select modulename | sort modulename -Unique).modulename
    }
        else{
        Write-Host "Process doesn't exist try again" -ForegroundColor Red
        }
foreach($item in $Modules){
$exe=Get-WmiObject -Namespace root\cimv2 -Class cim_processexecutable | ?{$_.antecedent -match "$item"} | Sort-Object antecedent -Unique
        foreach($item2 in $exe){
        [wmi]"$($item2.Antecedent)" | ? {$_.manufacturer -ne "Microsoft Corporation"}| select FileName,Extension,Manufacturer,Version | Export-Csv -Path $Filepath -Append
        

                               }
                           }

                    }
 }#End Get-ProcessModuleInfo
