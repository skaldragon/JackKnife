Function Get-Signature{

param(
[Parameter(Mandatory=$true)][string]$Path,
[Parameter(Mandatory=$true)][string]$Extension,
[Parameter(Mandatory=$true)][string]$StatusName
)
  Get-ChildItem -Path $Path -Recurse -File | Select FullName | Where-Object {$_.FullName -match "$Extension$"} | ForEach-Object {Get-AuthenticodeSignature -FilePath $_.FullName} | Where-Object {$_.Status -match "$StatusName"}
  }
