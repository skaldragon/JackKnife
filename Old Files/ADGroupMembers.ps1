$computers=(Get-ADComputer -Filter * | Select Name).Name
foreach($name in $computers){
if(Test-Connection $name -Count 2 -Quiet){
Get-WmiObject win32_group -Filter "LocalAccount='True'" -ComputerName $name | Select PSComputername,Name, @{Name="Members";Expression={ $_.GetRelated("win32_useraccount").Name-join ";"}} >>'C:\Users\$env:Username\Desktop\ADGroupMembers.txt'}}
