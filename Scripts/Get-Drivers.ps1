function Get-Drivers{
 #Gathers Kernel Driver information on the system
if($ErrorActionPreference -ne 'silentlycontinue'){
$ErrorActionPreference='silentlycontinue'
}
$var=(gwmi win32_baseservice | where{$_.servicetype -eq "kernel driver"} | select pathname).pathname
[system.collections.arraylist]$Drivers=@()
foreach($item in $var){
$Object=Get-Item -Path $item 
$signature=Get-AuthenticodeSignature -FilePath $item 
$signature2=Get-AuthenticodeSignature -FilePath $item
$signature=($signature | select -ExpandProperty Signercertificate).subject
$signature=$signature -replace '..=',''
$Table=[PSCustomObject]@{
Driver=$Object.versioninfo.InternalName
Version=$Object.versioninfo.ProductVersion
Product=$Object.versioninfo.productname
Status=$signature2.Status
StatusMessage=$signature2.StatusMessage
Signedby=$signature
}
$Drivers.Add($Table) | Out-Null

}
$Drivers
$ErrorActionPreference='Continue'
}
