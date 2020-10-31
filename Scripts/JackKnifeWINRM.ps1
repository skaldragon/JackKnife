$answer=Read-Host "Do you want to start the process to enable WinRM? Y for yes N for no"
switch ($answer){
Y { winrm quickconfig -quiet
$Path="C:\Users\$env:Username\Desktop\JackKnife\Results\WINRMResults"
Write-Host "Gathering Network Connection Profiles(...)"
Write-Host "Gathering Trusted Hosts(...)"
Get-NetConnectionProfile | Export-Csv -Path $Path\Netconnectionsinfo.csv
Get-Item WSMan:\localhost\Client\TrustedHosts | Export-Csv -Path $Path\TrustedHost.csv

Start-Sleep -s 5
}
N {$diable=Read-Host "Do you want to disable winrm and remover yourself as a trusted host? Y for yes N for no"}
}
$answer2=Read-Host "Do you want to add a TrustedHost? Y for yes N for no"
switch($answer2){
Y { $Value=Read-Host "What's the host name you want to add to the TrustedHosts?"
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value $Value
	Get-Item WSMan:\localhost\Client\TrustedHosts  | Export-Csv -Path $Path\TrustedHostChanges.csv
	$Alias=Read-Host "Check the Netconnectionsinfo.csv for which Alias you want to convert to private and enter it here"
	Set-NetConnectionProfile -InterfaceAlias $Alias -NetworkCategory private
	}
N {  }
}
switch($diable){
Y { $newvalue = ((Get-ChildItem WSMan:\localhost\Client\TrustedHosts).Value).Replace($env:ComputerName," ")
Set-Item WSMan:\localhost\Client\TrustedHosts $newvalue
net stop winrm}
N {  }
}
