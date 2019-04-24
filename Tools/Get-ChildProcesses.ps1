function Get-ChildProcesses{
param(
[Parameter()]$RunningProcesses=(Get-WmiObject win32_process | select processid).processid
)
foreach($ID in $RunningProcesses){
Get-WmiObject win32_process | Where-Object{$_.processid -eq "$ID"| Select ProcessName,@{Name="ChildProcess";Expression=[((Get-WmiObject win32_process|Where-Object{$_.parentprocessid -eq "$ID"} | select processname).Processname) -join "`n"}} | Export-Csv -Path C:\users\$env:username\desktop\ParentToChildProcesses.csv -append
}
}