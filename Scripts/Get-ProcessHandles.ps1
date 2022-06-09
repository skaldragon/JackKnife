function Get-ProcessHandles {
#This Functions is to get Information about the handles loaded into running processes
param(
#Name of Process that is running, do not add .exe to end of name
[parameter(Mandatory =$true)][string]$Processname,
#Filepath to save infomation of results.
[parameter(Mandatory =$true)][string]$Filepath,
#Non-Microsoft signed modules
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
 }#End Get-ProcessHandles
