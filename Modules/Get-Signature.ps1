Function Get-Signature{

param(
[Parameter(Mandatory=$true)][string]$Path,
[Parameter(Mandatory=$true)][string]$Extension,
[Parameter(Mandatory=$false,ParameterSetName="Validation")][switch]$Validate,
[Parameter(Mandatory=$false,ParameterSetName="Validation")][string]$StatusName
)
 if($Validate){
  Get-ChildItem -Path $Path -Recurse -File | Select FullName | Where-Object {$_.FullName -match "$Extension$"} | ForEach-Object {Get-AuthenticodeSignature -FilePath $_.FullName} | Where-Object {$_.Status -match "$StatusName"}
  }
  else{
  Get-ChildItem -Path $Path -Recurse -File | Select FullName | Where-Object {$_.FullName -match "$Extension$"} | ForEach-Object {Get-AuthenticodeSignature -FilePath $_.FullName} | Where-Object {$_.Status -ne "Valid"}
  }
  }