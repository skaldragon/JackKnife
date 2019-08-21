#The goal of this script is to be able to look for any file withing a computer system no matter the name or pattern of name it may contain.

function Search-File{
[cmdletBinding(DefaultParameterSetName="Set One")]
param(
[Parameter(Mandatory=$true,ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][string]$HostPath,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][string]$Extension,
[Parameter(ParameterSetName="Set One")][switch]$Include,
[Parameter(ParameterSetName="Set One")][switch]$Exclude,
[Parameter(ParameterSetName="Set Two")][string]$FileName,
[Parameter(ParameterSetName="Set Two")][switch]$SearchforRandom,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$SearchforNormal,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")]$Hostcomputers=@(),
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$All,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$HostList,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$LocalHost
)


if($HostList){
foreach($Computer in $Hostcomputers){
(Get-ADComputer $Computer).Name
$Session=New-PSSession -ComputerName $Computer -Authentication Negotiate

if($Include){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
Invoke-Command -Session $Session-ScriptBlock{Get-ChildItem $Using:HostPath -Include "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
}

if($Exclude){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Exclude "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
}

if($SearchforRandom){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{$length=Read-Host "Enter in a file length";Get-ChildItem "$Using:HostPath" -Recurse -Include *$Using:Extension | Where-Object {$_.Name -match "^[\w]{0,20}?" -and $_.Basename.Length -le $length}} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
}

if($SearchforNormal){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Name $using:FileName -Recurse -Force}  | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
}

Remove-PSSession *
} #End FOREACH
} #END SELECTED

if($All){
$Names=(Get-ADComputer -Filter * | Select Name).name

foreach($Computer in $Names){
if(Test-Connection -ComputerName $Computer -Count 1){
$Session=New-PSSession -ComputerName $Computer -Authentication Negotiate

if($Include){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Include "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
}
if($Exclude){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Exclude "*$Using:Extension" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
}
if($SearchforRandom){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Read-Host "Enter in a file length";Get-ChildItem "$Using:HostPath" -Recurse -Include *$Using:Extension | Where-Object {$_.Name -match "^[\w]{0,20}?" -and $_.Basename.Length -le $length}} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
}
if($SearchforNormal){
Invoke-Command -Session $Session -ScriptBlock{echo "-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Name $using:FileName -Force -Recurse}  | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
}
Remove-PSSession * -ErrorAction SilentlyContinue
} #END IF
}#END FOREACH
}#END ALL

if($LocalHost){
$Computer=$env:COMPUTERNAME

if($Include){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
Get-ChildItem $HostPath -Include "*$Extension" -Recurse -Force | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
}

if($Exclude){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
Get-ChildItem $HostPath -Exclude "*$Extension" -Recurse -Force | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
}

if($SearchforRandom){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
$length=Read-Host "Enter in a file length";Get-ChildItem "$HostPath" -Recurse -Include *$Extension | Where-Object {$_.Name -match "^[\w]{0,20}?" -and $_.Basename.Length -le $length} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
}

if($SearchforNormal){
echo "-----$env:COMPUTERNAME-----" | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
Get-ChildItem "$HostPath" -Name $FileName -Recurse -Force  | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
}#End IF
}#EndLocal
}#EndFunction
