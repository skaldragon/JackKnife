 function Persist-Action{
 [CmdletBinding(DefaultParameterSetName="Netstat")]
 
 param(
 [Parameter(Mandatory=$false,Parametersetname="Netstat")][Parameter(Parametersetname="Processes")][Parameter(Parametersetname="Logs")][int]$IntervalSeconds,
 [Parameter(Mandatory=$false,Parametersetname="Netstat")][switch]$Netstat,
 [Parameter(Mandatory=$false,Parametersetname="Processes")][switch]$Processes,
 [Parameter(Mandatory=$false,Parametersetname="Logs")][switch]$Logs,
  [Parameter(Mandatory=$true,Parametersetname="Logs")][string]$LogName
)
 if($Netstat){
 $i=0
 while($i -eq "0"){
 $net=Get-NetTCPConnection
 sleep -s $IntervalSeconds
 $net2=Get-NetTCPConnection
 if ($net -ne $net2){
 Write-Host "There are new connections" 
 $compare=Compare-Object -ReferenceObject $net -DifferenceObject $net2
 $compare | Where-Object {$_.sideindicator -eq "=>"} | Select -ExpandProperty Inputobject| Out-File -FilePath C:\users\$env:USERNAME\desktop\NetstatConnections.txt -Append;(Get-Date).DateTime + "`n" | Out-File -FilePath C:\users\$env:USERNAME\desktop\NetstatConnections.txt -Append} 
}
}#End if $Netstat
if($Processes){
$i=0
 while($i -eq "0"){
 $process=Get-Process
 sleep -s $IntervalSeconds
 $process2=Get-Process
 if ($process -ne $process2){
 $compare=Compare-Object -ReferenceObject $log -DifferenceObject $process2
 $compare | Where-Object {$_.sideindicator -eq "=>"} | Select -ExpandProperty Inputobject| Out-File -FilePath C:\users\$env:USERNAME\desktop\Processes.txt -Append;(Get-Date).DateTime + "`n" | Out-File -FilePath C:\users\$env:USERNAME\desktop\Processes.txt -Append} 
}

} #End Process

if($Logs){
$i=0
 while($i -eq "0"){
 $log=Get-EventLog -LogName $LogName
 sleep -s $IntervalSeconds
 $log2=Get-EventLog -LogName $LogName
 if ($log -ne $log2){
 $compare=Compare-Object -ReferenceObject $log -DifferenceObject $log2
 $compare | Where-Object {$_.sideindicator -eq "=>"} | Select -ExpandProperty Inputobject| Out-File -FilePath C:\users\$env:USERNAME\desktop\$LogName"logs".txt -Append;(Get-Date).DateTime + "`n" | Out-File -FilePath C:\users\$env:USERNAME\desktop\$LogName"logs".txt -Append} 




 }
 } # End Logs
 } 
