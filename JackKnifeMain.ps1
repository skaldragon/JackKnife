$title = "JackKnife Main Menu Tool Selector"
mkdir "C:\Users\$env:Username\Desktop\JackKnife"
Copy-Item -Path "C:\Users\$env:Username\Desktop\JackKnife\Modules" -ToSession $ConnectSession -Path "C:\Users\$env:Username\Desktop\JackKnife"
Write-Host $title
Write-Host "0:JackKnife Registry Comparitor"
Write-Host "1:JackKnife ADS Searcher"
Write-Host "2:JackKnife WINRM Configurer"
$result = Read-Host "Make a Selection"
switch ($result){
	0{ Import-Module .\Modules\JackKnifeREG.psm1}
	1{ Import-Module .\Modules\JackKnifeADS.psm1}
	2{ Import-Module .\Modules\JackKnifeWINRM.psm1}
	}
rmdir "C:\Users\$env:Username\Desktop\JackKnife"
