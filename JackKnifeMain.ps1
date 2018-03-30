$title = "JackKnife Main Menu Tool Selector"
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
