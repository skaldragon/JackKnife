#Gathers Active Directory Group Information﻿
Get-ADGroup -Filter {Members -ne "NULL"} -properties Name | Select-Object Name, @{Name="GroupMembers";Expression={(Get-ADGroupMember -identity "$_" | Select-Object -ExpandProperty SamAccountName) -join "`n"}} | Export-Csv -Path C:\users\$env:username\desktop\ADGroupMembers.csv -Append
