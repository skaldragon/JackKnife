$computer=(Get-ADUser -Filter(SamAccountName -ne "NULL") -Properties *)
$computer|Export-Csv C:\Users\$env:USERNAME\Desktop\ADUserinfo.csv
