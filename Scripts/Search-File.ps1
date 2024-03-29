function Search-File{
<#
	.SYNOPSIS
		This function has the capability to find any type of file on any file system
	.PARAMETER HostPath
		The local or UNC folder path that you'd like to search files in recursively.
	.PARAMETER Extension
		The type of file you are looking for, foreach loops with multiple extensions will work for this as well.
	.PARAMETER Include and Exclude
		Whether or not to include the extension or exclude it from search results.
	.PARAMETER Filename
		Used if you're searching with SearchforNormal switch to find normal files with specific filenames and extensions.
	.SWITCH SearchForRandom
		Uses Regex to find files with varying file names, can be used with different extensions and file lengths.
	.SWITCH SearchForNormal
		Searches for specific file names and extensions.
	.PARAMETER HostComputers
		Array to add multiple computers one by one separated by comma if you don't want to search the whole AD.
    .SWITCH All
		Used to search all of AD.
    .SWITCH Regexname
        Used to state the filename is a regexname
    .EXAMPLE
     Search-File -HostPath C:\users -Regexname ^`$[2-3] -LocalHost
     .SWITCH Datesearch
        Used to find files by Creation timestamps of MM/DD/YYYY, used with the Date parameter
    .EXAMPLE
      Search-File -HostPath C:\users -Date 12/12/2012 -Datesearch -LocalHost
    .SWITCH Hostlist
		Used with HostComputers to search list of computers instead of AD.
    .SWITCH LocalHost
		Used to search only the local system.
	.EXAMPLE
	 Search-File -Hostpath C:\users -extension .exe -SearchforRandom -localhost
	.EXAMPLE 
	 Search-File -Hostpath C:\users -Filename evil.exe -SearchforNormal -All
	.EXAMPLE 
	 Search-File -Hostpath C:\users -extension .ppt -exclude -SearchforRandom -HostList -Hostcomputers server1,server2,server3
	.OUTPUTS
	Outputs results in the PWD in a .txt file.
		#>

[cmdletBinding(DefaultParameterSetName="Set One")]
param(
[Parameter(Mandatory=$true,ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")]
[Parameter(ParameterSetName="Set Three")][Parameter(ParameterSetName="Set Four")][string]$HostPath,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][string]$Extension,
[Parameter(ParameterSetName="Set One")][switch]$Include,
[Parameter(ParameterSetName="Set One")][switch]$Exclude,
[Parameter(ParameterSetName="Set Two")][string]$FileName,
[Parameter(ParameterSetName="Set Two")][switch]$SearchforRandom,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$SearchforNormal,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")]$Hostcomputers=@(),
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][Parameter(ParameterSetName="Set Three")][Parameter(ParameterSetName="Set Four")][switch]$All,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][Parameter(ParameterSetName="Set Three")][Parameter(ParameterSetName="Set Four")][switch]$HostList,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][Parameter(ParameterSetName="Set Three")][Parameter(ParameterSetName="Set Four")][switch]$LocalHost,
[Parameter(ParameterSetName="Set Three")][string]$Regexname,
[Parameter(ParameterSetName="Set Four")][switch]$Datesearch,
[Parameter(ParameterSetName="Set Four")][string]$Date
)


Write-Host "Choose file location to save to, do not include extension" -ForegroundColor Red
Sleep -s 5
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$null = $FileBrowser.ShowDialog()
$File2save=$FileBrowser.FileName



if($HostList){
foreach($Computer in $Hostcomputers){
(Get-ADComputer $Computer).Name
$Session=New-PSSession -ComputerName $Computer -Authentication Negotiate

if($Include){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Inclusionfiles.txt" -Append;
Invoke-Command -Session $Session-ScriptBlock{Get-ChildItem $Using:HostPath -Include "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $File2save"_Inclusionfiles.txt" -Append;
}

if($Exclude){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Exclusionfiles.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Exclude "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $File2save"_Exclusionfiles.txt" -Append;
}

if($SearchforRandom){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Randomfile.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{$length=Read-Host "Enter in a file length";Get-ChildItem "$Using:HostPath" -Recurse -Include *$Using:Extension | Where-Object {$_.Name -match "^[\w]{$length}?" -and $_.Basename.Length -le $length}} | Out-File -FilePath $File2save"_Randomfile.txt" -Append;
}

if($SearchforNormal){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Normalfile.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Name $using:FileName -Recurse -Force}  | Out-File -FilePath $File2save"_Normalfile.txt" -Append;
}
if($Regexname){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Regexfile.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Recurse -Force |Where-Object{$_.name -match "$Using:Regexname"}}  | Out-File -FilePath $File2save"_RegexNamefile.txt" -Append;
}#End IF
if($Datesearch){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Datefiles.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{ $time=(gci -Path "$Using:HostPath" | select * | ?{$_.CreationTime.ToShortDateString() -icontains $Using:Date})
$time} | Out-File -FilePath $File2save"_Datefiles.txt" -Append;
}#End IF
Remove-PSSession *
} #End FOREACH
} #END SELECTED

if($All){
$Names=(Get-ADComputer -Filter * | Select Name).name

foreach($Computer in $Names){
if(Test-Connection -ComputerName $Computer -Count 1){
$Session=New-PSSession -ComputerName $Computer -Authentication Negotiate

if($Include){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Inclusionfiles.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Include "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $File2save"_Inclusionfiles.txt" -Append;
}
if($Exclude){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Exclusionfiles.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Exclude "*$Using:Extension" -Recurse -Force} | Out-File -FilePath "$File2save"_Exclusionfiles.txt -Append;
}
if($SearchforRandom){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Randomfile.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Read-Host "Enter in a file length";Get-ChildItem "$Using:HostPath" -Recurse -Include *$Using:Extension | Where-Object {$_.Name -match "^[\w]{$length}?" -and $_.Basename.Length -le $length}} | Out-File -FilePath $File2save"_Randomfile.txt" -Append;
}
if($SearchforNormal){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Normalfile.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Name $using:FileName -Force -Recurse}  | Out-File -FilePath $File2save"_Normalfile.txt" -Append;
}
if($Regexname){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Regexfile.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Recurse -Force |Where-Object{$_.name -match "$Using:Regexname"}}  | Out-File -FilePath $File2save"_RegexNamefile.txt" -Append;
}#End IF
if($Datesearch){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $File2save"_Datefiles.txt" -Append;
Invoke-Command -Session $Session -ScriptBlock{ $time=(gci -Path "$Using:HostPath" | select * | ?{$_.CreationTime.ToShortDateString() -icontains $Using:Date})
$time} | Out-File -FilePath $File2save"_Datefiles.txt" -Append;
}#End IF
Remove-PSSession * -ErrorAction SilentlyContinue
} #END IF
}#END FOREACH
}#END ALL

if($LocalHost){
$Computer=$env:COMPUTERNAME

if($Include){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $File2save"_Inclusionfiles.txt" -Append;
Get-ChildItem $HostPath -Include "*$Extension" -Recurse -Force | Out-File -FilePath $File2save"_Inclusionfiles.txt" -Append;
}

if($Exclude){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $File2save"_Exclusionfiles.txt" -Append;
Get-ChildItem $HostPath -Exclude "*$Extension" -Recurse -Force | Out-File -FilePath $File2save"_Exclusionfiles.txt" -Append;
}

if($SearchforRandom){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $File2save"_Randomfile.txt" -Append;
$length=Read-Host "Enter in a file length";Get-ChildItem "$HostPath" -Recurse -Include *$Extension | Where-Object {$_.Name -match "^[\w]{$length}?" -and $_.Basename.Length -le $length} | Out-File -FilePath $File2save"_Randomfile.txt" -Append;
}

if($SearchforNormal){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $File2save"_Normalfile.txt" -Append;
Get-ChildItem "$HostPath" -Name $FileName -Recurse -Force  | Out-File -FilePath $File2save"_Normalfile.txt" -Append;
}
if($Regexname){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $File2save"_Regexfile.txt" -Append;
Get-ChildItem "$HostPath" -Recurse -Force |Where-Object{$_.name -match "$Regexname"}  | Out-File -FilePath $File2save"_RegexNamefile.txt" -Append;
}
if($Datesearch){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $File2save"_Datefiles.txt" -Append;
$time=(gci -Path $HostPath | select * | ?{$_.CreationTime.ToShortDateString() -icontains $Date})
$time | Out-File -FilePath $File2save"_Datefiles.txt" -Append;
}#End IF
}#EndLocal
}#EndFunction
