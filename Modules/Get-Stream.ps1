function Get-Stream {
[CmdletBinding(DefaultParameterSetName="Set1")]


param(
[Parameter(Mandatory=$true, ParameterSetName="Set1")][Parameter(ParameterSetName="Set2")][string]$Filepath,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][string]$Content,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][string]$StreamName,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][switch]$Remove,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][switch]$AddStream,
[Parameter(Mandatory=$false,ParameterSetName="Set1")][switch]$View,
[Parameter(Mandatory=$false,ParameterSetName="Set1")][switch]$Unique

) 

Get-ChildItem -Path $Filepath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Select Filename,Stream | Sort
if($Remove){
Remove-Item -Path $FilePath -Stream $StreamName
}
if($View){
Write-Host
}
if($AddStream){
Add-Content -Stream $StreamName -Value $Content -Path $Filepath
}
if($Unique){
Get-ChildItem -Path $path -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA'}
}
}