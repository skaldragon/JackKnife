#The goal of this script is to be able to look for any file withing a computer system no matter the name or pattern of name it may contain.

function Search-File{
[cmdletBinding(DefaultParameterSetName="Set One")]
param(
[Parameter(Mandatory=$true,ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][string]$HostPath,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][string]$Extention,
[Parameter(ParameterSetName="Set One")][switch]$Include,
[Parameter(ParameterSetName="Set One")][switch]$Exclude,
[Parameter(ParameterSetName="Set Two")][string]$FileName,
[Parameter(ParameterSetName="Set Two")][switch]$SearchforRandom,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$SearchforNormal,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")]$Hostcomputers=@(),
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$All,
[Parameter(ParameterSetName="Set One")][Parameter(ParameterSetName="Set Two")][switch]$Selected
)


if($Selected){
foreach($Computer in $Hostcomputers){
(Get-ADComputer $Computer).Name
$Session=New-PSSession -ComputerName $Computer -Authentication Negotiate

if($Include){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
Invoke-Command -Session $Session-ScriptBlock{Get-ChildItem $Using:HostPath -Include "*$Using:Extention" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
}

if($Exclude){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Exclude "*$Using:Extention" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
}

if($SearchforRandom){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Recurse -Include *$Using:Extention | Where-Object {$_.Name -match "^s[\w]{0,20}?"}} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
}

if($SearchforNormal){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Name $using:FileName}  | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
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
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Include "*$Using:Extention" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Inclusionfiles.txt -Append;
}
if($Exclude){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem $Using:HostPath -Exclude "*$Using:Extention" -Recurse -Force} | Out-File -FilePath $pwd\"$Computer"_Exclusionfiles.txt -Append;
}
if($SearchforRandom){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Recurse -Include *$Using:Extention | Where-Object {$_.Name -match "^s[\w]{0,20}?"}} | Out-File -FilePath $pwd\"$Computer"_Randomfile.txt -Append;
}
if($SearchforNormal){
Invoke-Command -Session $Session -ScriptBlock{echo"-----$env:COMPUTERNAME-----"} | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
Invoke-Command -Session $Session -ScriptBlock{Get-ChildItem "$Using:HostPath" -Name $using:FileName}  | Out-File -FilePath $pwd\"$Computer"_Normalfile.txt -Append;
}
Remove-PSSession * -ErrorAction SilentlyContinue
} #END IF
}#END FOREACH
}#END ALL
}#END FUNCTION
