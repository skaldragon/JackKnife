function Get-BetterNetstat{
<#
.SYNOPSIS
Does what Netstat -anob does except without having to be Administrator.
    #>
$TCP=Get-NetTCPConnection | select *
$Processes=gwmi win32_process | select Processname,ProcessID

[System.Collections.ArrayList]$TCPARRAY = @()

foreach($item in $TCP){
if($item.OwningProcess -iin $Processes.ProcessID)
{
$Name=($Processes |?{$_.ProcessID -eq $item.OwningProcess} | select ProcessName).Processname


$TCPFields=[PSCustomObject]@{
LocalAddress=$item.LocalAddress
LocalPort=$item.LocalPort
RemoteAddress=$item.RemoteAddress
RemotePort=$item.RemotePort
ProcessID=$item.OwningProcess
ProcessName=$Name
State=$item.state | ?{$_.state -ne "Bound"}
}
}
$TCPARRAY.Add(($TCPFields)) | Out-Null
}
$TCPARRAY
}
