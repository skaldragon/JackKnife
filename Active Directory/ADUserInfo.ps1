$computer=(Get-ADUser -Filter * -Properties *)
$computer|Export-Csv C:\Users\$env:USERNAME\Desktop\ADUserinfo.csv