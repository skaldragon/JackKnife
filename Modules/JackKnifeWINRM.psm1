$answer=Read-Host "Do you want to start the process to enable WinRM? Y for yes N for no"
switch ($answer){
Y { winrm quickconfig -quiet
$Path=Read-Host "Give a path for your saved information"
Write-Host "Gathering Network Connection Profiles(...)"
Get-NetConnectionProfile | Export-Csv -Path $Path\Netconnectionsinfo.csv

Start-Sleep -s 5
}
N { ""}
}


