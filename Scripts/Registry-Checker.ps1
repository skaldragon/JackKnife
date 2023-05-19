function Registry-Checker{
param(
[Parameter(Mandatory=$false)][switch]$compare,
[Parameter(Mandatory=$false)][switch]$localfile
)

if($compare){
    if($localfile){
#Chooses local file to compare final results
Write-Host "Choose first csv file to compare" -ForegroundColor Red
Sleep -s 3
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$null = $FileBrowser.ShowDialog()
$OpenedFile=$FileBrowser.FileName

Write-Host "Choose second csv file to compare" -ForegroundColor Red
Sleep -s 3
$FileBrowser2 = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$null = $FileBrowser2.ShowDialog()
$OpenedFile2=$FileBrowser2.FileName
$Hash1=(Get-FileHash $OpenedFile).hash
$Hash2=(Get-FileHash $OpenedFile2).hash

if($Hash1 -ne $Hash2 ){
Write-host "The registry files have changed" -ForegroundColor Red
}#End If
else{
Write-host "The registry files have not changed" -ForegroundColor Green
}#End else
}#End localfile
else{
Write-Host "Grabbing Registry information []...."
[System.Collections.ArrayList]$Registry=@(
"HKLM:\Software\Microsoft\Windows\CurrentVersion\Run","HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce","HKLM:\System\CurrentControlSet\Services","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce","HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices",
"HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServices","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit","HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell",
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx","HKCU:\Software\Microsoft\Windows\CurrentVersion\Run","HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run",
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run","HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows\load","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs",
"HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\BootExecute"
)
Write-Host "Choose a place to save file DO NOT ADD EXTENSION" -ForegroundColor Red
Sleep -s 3
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$null = $FileBrowser.ShowDialog()
$SavedFile=$FileBrowser.FileName + ".csv"
foreach($key in $Registry){



Get-ItemProperty $key -ErrorAction SilentlyContinue >> $SavedFile
}
Write-Host "Choose a csv file to compare" -ForegroundColor Red
Sleep -s 3
$FileBrowser2 = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$null = $FileBrowser2.ShowDialog()
$SavedFile=$FileBrowser2.FileName
$Hash1=(Get-FileHash $OpenedFile).hash
$Hash2=(Get-FileHash $OpenedFile2).hash

if($Hash1 -ne $Hash2 ){
Write-host "The registry files have changed" -ForegroundColor Red
}#End If
else{
Write-host "The registry files have not changed" -ForegroundColor Green
}#End else


}#End Else



}#End Compare
else{
Write-Host "Grabbing Registry information []...."
[System.Collections.ArrayList]$Registry=@(
"HKLM:\Software\Microsoft\Windows\CurrentVersion\Run","HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce","HKLM:\System\CurrentControlSet\Services","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce","HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices",
"HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServices","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit","HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell",
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce","HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx","HKCU:\Software\Microsoft\Windows\CurrentVersion\Run","HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run",
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run","HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows\load","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler","HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs",
"HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\BootExecute"
)
Write-Host "Choose a place to save file DO NOT ADD EXTENSION" -ForegroundColor Red
Sleep -s 3
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$null = $FileBrowser.ShowDialog()
$SavedFile=$FileBrowser.FileName + ".csv"
foreach($key in $Registry){



Get-ItemProperty $key -ErrorAction SilentlyContinue >> $SavedFile
}
}#End Else

}#End Registry-Checker
