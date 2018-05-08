cd C:\WINDOWS\system32
## Lists Files within Directory and the alternate data streams associated with them
$title = "JackKnife's Alternate Data Stream Sorter"
$path = Read-Host 'What is the path you want search ex: U:\?'
$file = Read-Host 'What file name do you want to give the output to?'
$filepath = "C:\Users\$env:Username\Desktop\JackKnife\JackKnife\Results\ADSResults"
$result = Read-Host "Do you want to sort the results uniquely by the Alternate Data Stream? Y for yes N for no"



switch ($result){
	Y {Get-ChildItem -Path $path -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Select Stream | Export-Csv -Path $filepath\$file.csv 
		Get-Content $filepath\$file.csv | Sort | Get-Unique | Export-Csv -Path $filepath\$($file)2.csv 
		Copy-Item $filepath\$($file)2.csv $filepath\$file.csv ;
		Remove-Item $filepath\$($file)2.csv ;}
	N {Get-ChildItem -Path $path -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Export-Csv -Path $filepath\$file.csv }
}

$title2 = "JackKnife's `$DATA Remover"
$message2 = "Do you want exclude the normal `$DATA stream indicator?"
Write-Host "WARNING IF YOU ALREADY SORTED THE DATA YOU SHOULDN'T RID OF THE `$DATA STREAM, IT WILL OVERWRITE YOUR PREVIOUS ENTRY" -ForegroundColor red
$yes2 = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Removes the normal $DATA stream."
$no2 =  New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Does not remove."

$options2 = [System.Management.Automation.Host.ChoiceDescription[]]($yes2, $no2)

$result2 = $Host.UI.PromptForChoice($title2, $message2, $options2, 0)

switch ($result2){
	0 {Get-ChildItem -Path $path -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA'} | Export-Csv -Path $filepath\$file.csv }
	1 {""}
}
# Creates a file and then sorts out the data to be parsed later within the sequence of processing the information.
$title3 = "JackKnife's ADS Data Revealer ALL FILES"
$message3 = "Do you want to view all streams from all files?"
Write-Host "WILL TAKE ALL THE DATA FROM ALL THE FILES AND IMPORT INTO A CSV " -ForegroundColor red
$yes3 = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Reveals the ADS Data"
$no3 =  New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Does not reveal."
#
$options3 = [System.Management.Automation.Host.ChoiceDescription[]]($yes3, $no3)
#
$result3 = $Host.UI.PromptForChoice($title3, $message3, $options3, 0)
#
switch ($result3){
	0 {$x = Get-ChildItem -Path $path -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA'} }
	1 {""}
}
#
ForEach($results in $x)
{Get-Content -Path $results.FileName -stream $results.Stream >> $filepath\ALLResults.csv}
#
#
$title5 = "JackKnife's ADS Data Revealer Single File"
$message5 = "Do you want to view a stream from a file?"
Write-Host "WILL TAKE ALL THE DATA FROM A SINGLE FILE AND IMPORT INTO A CSV `n LOOK INTO THE TEXT FILE YOU NAMED TO MAKE DETERMINATION! " -ForegroundColor red
$yes5 = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Reveals the ADS Data"
$no5 =  New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Does not reveal."

$options5 = [System.Management.Automation.Host.ChoiceDescription[]]($yes5, $no5)

$result5 = $Host.UI.PromptForChoice($title5, $message5, $options5, 0)

switch ($result5){
	0 { $filepath2 = Read-Host " What is the path you want to look at?" ;
	$stream = Read-Host " What is the stream name?"
	 Get-Content -Path $filepath2 -stream $stream >> $filepath\SingleResults.csv}
	1 {""}
}
#
#
$title4 = "JackKnife's ADS Data Remover"
$message4 = "Do you want to remove a stream from a file?"
$yes4 = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Removes the ADS."
$no4 =  New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Does not remove."
#
$options4 = [System.Management.Automation.Host.ChoiceDescription[]]($yes4, $no4)
#
$result4 = $Host.UI.PromptForChoice($title4, $message4, $options4, 0)
#
switch ($result4){
	0 {$filepath3 = Read-Host 'What path is this file at?' ;
	$stream2 = Read-Host 'Name of ADS associated with file in file path?' ;
	Remove-Item -Path $filepath3 -stream $stream2 ;
	Write-Host "STREAM REMOVED!!!" -ForegroundColor red }
	1 {""}
}
