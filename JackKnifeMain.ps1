$title = "JackKnife Main Menu Tool Selector"
$Zip="C:\Users\$env:Username\Desktop\JackKnife.zip"
$DEST="C:\Users\$env:Username\Desktop\JackKnife"
$Check=Test-Path -Path !$Zip
if ($Check -ne "True"){
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($Zip, $DEST)
}
cd "C:\Users\$env:Username\Desktop\JackKnife"
Write-Host $title
Write-Host "0:JackKnife Registry Comparitor"
Write-Host "1:JackKnife ADS Searcher"
$result = Read-Host "Make a Selection"
switch ($result){
	0{ Import-Module .\JackKnife\Modules\JackKnifeREG.psm1}
	1{ Import-Module .\JackKnife\Modules\JackKnifeADS.psm1}
	}

