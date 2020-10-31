Function Encrypt-File{
param(
[Parameter(Mandatory=$true)][string]$SourcePath,
[Parameter(Mandatory=$true)][string]$SrcFileName,
[Parameter(Mandatory=$true)][string]$DestinationPath,
[Parameter(Mandatory=$true)][string]$DestFilename
)
$String= Get-content "C:\Users\$env:Username\Desktop\JackKnife\JackKnife\Key.txt";
$String=$String.Split(",").Replace("`(","").Replace("`)","");
[byte[]]$key=$String;
$script = Get-Content $SourcePath\$SrcFileName | Out-String;
$secure = ConvertTo-SecureString $script -AsPlainText -force;
$export = ConvertFrom-SecureString $secure -key $key;
Set-Content $DestinationPath\$DestFileName $export;
rm $SourcePath\$SrcFileName;
}