function Get-Stream {
<#
	.SYNOPSIS
		This function has the capability to find,add and remove Alternate Data Streams from files on a system.
	.PARAMETER FilePath
		The local or UNC folder path that you'd like to view streams at. Doesn't have to end in a file format it has the ability to just search the folder in general
	.PARAMETER $Content
		The Data you want to add to a file or a newly created stream.
	.PARAMETER StreamName
		The Name of the stream you are looking to view or add depending on which parameter set you use.
	.PARAMETER Remove
		Switch Parameter to Remove ADS from chosen file/files.
	.PARAMETER AddStream
		Adds a stream to a chosen file/files.
	.PARAMETER View
		Views Chosen Stream's Data
	.PARAMETER Unique
		Switch Parameter to Unique on ADS names within files on the system
	.EXAMPLE
	 Get-Stream -Filepath "YourFilePath"
	.EXAMPLE Content,AddStream,StreamName
	 Get-Stream -FilePath "YourFilePath" -StreamName "MyStream" -Content "Hello" -AddStream
	.EXAMPLE View
	 Get-Stream -StreamName "StreamName" -FilePath "Filepath" -View
	.EXAMPLE Unique
	 Get-Stream -FilePath "YourFilePath" -Unique
	 .INPUTS
	This function does not accept pipeline input.
	.OUTPUTS
	None but can be piped to export files.
		#>

[CmdletBinding(DefaultParameterSetName="Set1")]


param(
[Parameter(Mandatory=$true, ParameterSetName="Set1")][Parameter(ParameterSetName="Set2")][string]$Filepath,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][string]$Content,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][string]$StreamName,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][switch]$Remove,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][switch]$AddStream,
[Parameter(Mandatory=$false,ParameterSetName="Set2")][switch]$View,
[Parameter(Mandatory=$false,ParameterSetName="Set1")][switch]$Unique

) 
if ($FilePath -and !$Unique -and !$Content -and !$StreamName -and !$Remove -and !$AddStream -and !$View){
Get-ChildItem -Path $Filepath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Select Filename,Stream
}
if($Remove){
Remove-Item -Path $FilePath -Stream $StreamName
}
if($View){
Get-Content -Stream $StreamName -Path $Filepath 
}
if($AddStream){
Add-Content -Stream $StreamName -Value $Content -Path $Filepath
}
if($Unique){
$var=(Get-ChildItem -Path $FilePath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA' -and $_.Stream -ne "Zone.Identifier"}).Stream;
$var2=(Get-ChildItem -Path $FilePath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA' -and $_.Stream -ne "Zone.Identifier"}).FileName;
write-host "These are your Unique Stream names:" ; 
write-host $var2 -ForegroundColor red ; 
write-host $var -ForegroundColor red
}
}
