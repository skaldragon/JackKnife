$Computer=(Get-ADComputer -Filter * | Select Name).Name
Foreach($item in $Computer){
if ( Test-Connection -Count 2 -ComputerName $item){
$name=(Get-WmiObject -ComputerName $item win32_loggedonuser | Select antecedent) | Out-string;
$name.Replace("\\.\root\cimv2:Win32_Account.Domain=","") >> C:\Users\$env:Username\Desktop\LoggedonUsers.txt
                                                   }
}