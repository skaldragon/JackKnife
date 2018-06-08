$computer=(Get-ADComputer -Filter {SamAccountName -ne "NULL"} | Select Name).name
if (Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\UnavailableHosts.txt){
Remove-Item -Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\UnavailableHosts.txt
}
if (Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\AvailableHosts.txt){
Remove-Item -Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\AvailableHosts.txt
}
foreach($item in $computer){
Write-Host "[+]Using sneaky ways to detect connectivity to $item"
$test=(Get-Service -Name winrm -ComputerName $item | Select Status).status
if($test -ne "Running"){
Write-host " Could not connect WINRM to $item" -ForegroundColor Yellow
if (!(Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife)){
New-Item  C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife -ItemType directory
}
if (!(Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts)){
New-Item  C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\JackKnife\Hosts -ItemType directory
}
if (!(Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\UnavailableHosts.txt)){
New-Item  C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\UnavailableHosts.txt -ItemType file
}
Echo $item "`n">> C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\UnavailableHosts.txt
}
if($test -eq "Running"){
write-host " Able to communicate via WINRM to $item" -ForegroundColor Green
if (!(Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife)){
New-Item  C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife -ItemType directory
}
if (!(Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts)){
New-Item  C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts -ItemType directory
}
if (!(Test-Path C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\AvailableHosts.txt)){
New-Item  C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\AvailableHosts.txt -ItemType file
}
echo $item "`n">> C:\users\$env:USERNAME\Desktop\JackKnife\JackKnife\Hosts\AvailableHosts.txt
}
}
