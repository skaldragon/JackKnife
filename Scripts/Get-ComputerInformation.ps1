function Get-ComputerInformation{
 #Gathers NetworkConnections, Exes clicked on, USB information, Previously Ran Executables by users and Software on your computersystem
param(
[parameter()][switch]$UserAssistInfo,
[parameter()][switch]$NetworkConnections,
[parameter()][switch]$BAMinfo,
[Parameter()][switch]$USBInfo,
[Parameter(ParameterSetName="Software")][switch]$Software,
[Parameter(ParameterSetName="Software")][switch]$Microsoft,
[Parameter(ParameterSetName="Software")][switch]$NotMicrosoft
)
if($Software){
[System.Collections.ArrayList]$SoftwareArray = @()

$name=Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
foreach($item in $name.name){$item=$item.Replace("HKEY_LOCAL_MACHINE","HKLM:");$prop=Get-ItemProperty -Path $item

foreach($field in $prop){

$SoftwareObject=[PSCustomObject]@{

Computername=$env:COMPUTERNAME
SoftwareName=$field.Displayname
Publisher=$field.Publisher
Version=$field.DisplayVersion
ExecutablePath=$field.ExePath
UninstallCommand=$field.UninstallString
Install=$field.InstallSource
} #End Object
$SoftwareArray.Add(($SoftwareObject)) | Out-Null
} #End Foreach
} #End Foreach
if($Microsoft){
$SoftwareArray | Where-Object{$_.Publisher -eq "Microsoft Corporation"}
} #End Microsoft
elseif($NotMicrosoft){
$SoftwareArray | Where-Object{$_.Publisher -ne "Microsoft Corporation"}
} #End NotMicrosoft

else{Return $SoftwareArray}
}

if($USBInfo){
gwmi Win32_USBControllerDevice |%{[wmi]($_.Dependent)} | Sort Manufacturer,Description,DeviceID | Ft -GroupBy Manufacturer Description,Service,DeviceID
}

if($BAMinfo){

$user=Read-Host "Enter in a User name, case sensitive"

$sid=(Get-CimInstance win32_useraccount | Where-Object {$_.name -eq "$user"} | select SID).SID

$BAM=(Get-ChildItem HKLM:\SYSTEM\CurrentControlSet\Services\bam\UserSettings | select name).name
[System.Collections.ArrayList]$EXEARRAY=@()
foreach($name in $BAM){
$SIDEND=$name.Replace("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\bam\UserSettings\","")
if($SIDEND -match $sid){


$name=$name.replace("HKEY_LOCAL_MACHINE","HKLM:");$exe=Get-ItemProperty -Path $name; 
$exename=($exe.psobject.Properties | select name).name
}
else{
}
foreach($item in $exename){
if($item -match "exe"){
$item2=$item
$item = $item -creplace '(?s)^.*\\', ''
$ExecutableArray=[pscustomobject]@{
Executable=$item
ExecutablePath=$item2

}
$EXEARRAY+=$ExecutableArray
}
}

}
return $EXEARRAY

}
if($NetworkConnections){
[System.Collections.ArrayList]$Networkinfoarray=@()
$Key=(Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\Currentversion\NetworkList\Signatures\Unmanaged' | select name).name
foreach($item in $Key){$item=$item.replace("HKEY_LOCAL_MACHINE","HKLM:"); $props=Get-ItemProperty $item
[System.Collections.ArrayList]$array=@()
$mac=Get-ItemProperty $item | select -expandproperty DefaultGatewayMac; foreach($item2 in $mac){$item2='{0:x}' -f $item2;if($item2.Length -eq "1"){$item2=$item2.Insert(0,0)};$array+=$item2} $macaddress=$array -join "-"

$Networkinfo=[pscustomobject]@{
Name= $props.Description
GatewayMacAddress=$macaddress
}
$Networkinfoarray+=$Networkinfo
}
return $Networkinfoarray
}
if($UserAssistInfo){
Write-Host " This will display all executables and apps you have clicked on your desktop" -ForegroundColor Red
Write-Host " [+]Loading information" -ForegroundColor Red
sleep -Seconds 15
[System.Collections.ArrayList]$wordarray=@()


$names=(Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist | select name).name
foreach($name in $names){
$name=$name.replace("HKEY_CURRENT_USER","HKCU:");
$props=Get-ItemProperty -Path $name\Count
$morenames=$props.psobject.Properties | Where-Object{$_.name -notlike "PS*"} | select name

foreach($rotname in $morenames){

Function Rot-Convert([string]$str, $n)
{
$value=""
For ($index= 0;$index -lt $str.length;$index++){
$ch= [byte][char]($str.substring($index,1))
if ($ch-ge 97 -and $ch -le 109){$ch=$ch+ $n} 
else {
if ($ch-ge 110 -and $ch -le 122){$ch=$ch- $n} 
else {
if ($ch-ge 65 -and $ch -le 77){$ch=$ch+ $n} 
else {
if ($ch-gt 78 -and $ch -le 90){$ch=$ch -$n}
}
}
}
$value=$value+ [char]$ch
}
Return $value
}

$converted=Rot-Convert -str $rotname -n 13
$converted=$converted.Replace("@{Nnzr=","")
$converted=$converted -creplace '(?s)^.*\\', ''
$converted=$converted.Replace("}","")
$wordarray+=$converted
$wordarray

}
}

}
}




