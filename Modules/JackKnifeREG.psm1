$title = "JackKnife Registry Selector"
Write-Host $title
Write-Host "0:HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
Write-Host "1:HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
Write-Host "2:HKLM\System\CurrentControlSet\Services"
Write-Host "3:HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
Write-Host "4:HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"
Write-Host "5:HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices"
Write-Host "6:HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices"
Write-Host "7:HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify"
Write-Host "8:HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit"
Write-Host "9:HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\\Shell"
Write-Host "10:HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\\Shell"
Write-Host "11:HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad"
Write-Host "12:HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
Write-Host "13:HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx"
Write-Host "14:HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
Write-Host "15:HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
Write-Host "16:HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
Write-Host "17:HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\load"
Write-Host "18:HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows"
Write-Host "19:HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler"
Write-Host "20:HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows\\AppInit_DLLs"
Write-Host "21:HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\BootExecute"
Write-Host "22:Run All"
$CurrentPath=".\JackKnife Project"
$result = Read-Host "Make a Selection"
$Path = "C:\Users\$env:Username\Desktop\JackKnife\Results\RegistryResults"
$file= Read-Host "Give a filename"
switch ($result){
0 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\Run  -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
1 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce  -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
2 { Get-ItemProperty  HKLM:\System\CurrentControlSet\Services  -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
3 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
4 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
5 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
6 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServices -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
7 { Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
8 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
9 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
10 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
11 { Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
12 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
13 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
14 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
15 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
16 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
17 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows\load -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
18 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
19 { Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
20 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
21 { Get-ItemProperty  HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\BootExecute -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
}
switch ($result){
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\Run -ErrorAction SilentlyContinue | Export-Csv -Path $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\System\CurrentControlSet\Services  -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServices -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows\load -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
22 { Get-ItemProperty  HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\BootExecute -ErrorAction SilentlyContinue  >>  $Path\$file.csv}
}


$answer= Read-Host "Do you want to compare the results? Y for Yes, N for No"
switch($answer){
Y { $Path2= Read-Host "What's the path of your importing file?"
	Import-Csv -Path $Path2
$FILEA= Read-Host "Give the full path of the newly created file"
	Import-Csv -Path $FileA
	if ((Get-FileHash -Path "$FILEA").hash -ne (Get-FileHash -Path "$Path2").hash)
	{echo "True" | Tee-Object -file $Path\HashResults.txt}
	if ((Get-FileHash -Path "$FILEA").hash -eq (Get-FileHash -Path "$Path2").hash){echo "False" | Tee-Object -file $Path\HashResults.txt}}
N { Write-Host "Ok that's fine"}
	}
	



