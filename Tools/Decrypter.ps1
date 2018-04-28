Function Decrypt-File{
param(
[Parameter(Mandatory=$true)][string]$SourcePath,
[Parameter(Mandatory=$true)][string]$SrcFileName,
[Parameter(Mandatory=$true)][string]$DestinationPath,
[Parameter(Mandatory=$true)][string]$DestFilename
)
$String= Get-content "C:\Users\$env:Username\Desktop\JackKnife\JackKnife\Key.txt";
$String=$String.Split(",").Replace("`(","").Replace("`)","");
[byte[]]$key=$String;
$script = Get-Content $SourcePath\$SrcFileName;
$secure2= ConvertTo-SecureString $script -key $key;
$export2=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure2);
$newstring= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($export2);
Set-Content $DestinationPath\$DestFilename $newstring;
rm $SourcePath\$SrcFileName;
}