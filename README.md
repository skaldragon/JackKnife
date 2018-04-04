# JackKnife
JackKnife is a Network Defense Tool Repository for Powershell. It is made up of one main script and multiple modules built within. JackKnife is currently in development and new material will be added when updated. Works on Powershell 3.0 and up. The idea and point of JackKnife is to have a huge repository of Network and Host analytical tools in one script and in one source of access.
Windows Remote Management(WINRM) is neccessary to run the main script and its modules. Remoting has been fixed to a single powershell.ps1 file agent to call on and updates will be added when polished and functionality is working!
*
# JackKnife Version 1.0
*	Added Alternate Data Streams Module
*	Added Registry Comparator Module
*	Added WINRM Module
*	Added JackKnife’s Main Script

# JackKnife Version 2.0
* Added a new Results folder for script saves
*	Fixed JackKnifeREG.psm1 to use local variables to apply to any host and added capability to save Results within its own directory
* Added onto JackKnifeWINRM.psm1 to allow adding local computer to Trusted hosts and enabling WINRM as well as Disabling and Removing
* Fixed JackKnifeADS.psm1 problems, fixed switch capabilities, got rid of error outputs, outports to CSV and own Results Folder
* Working on PSSession Script to be able to Invoke powershell scripts and modules on remote machines, WINRM has to be enabled on both hosts and the WINRM Disabling and Removing part of the script is for use after that's been established.
# JackKnife Version 3.0
* Removed WINRM Module to make it it's own Stand-alone script, read instructions within its folder
* PS-Session Remoting figured out and now there are commands to configure them.
* Main script configured for remoting on hosts.
* Requires WinRM to be running on local host and remote host to work
* Currently working on Prefetch file reader,Logs,and SHIMCache modules.

# Step 1: Configure WinRM:
* You can configure WinRM on your host machine running the JackKnifeWINRM.ps1 script, if WINRM is already enabled on your remote hosts and you can create a PSSession for those hosts move on to step 2.
# Step 2: Creating a new PS-Session
* Here is the command for creating a PsSession, keep in mind that this is all done before running any modules on the remote host.
* #Command: $Session= New-PSSession -ComputerName "Target Host" -Credential "Username"  #Normally this is done with domain credentials.
# Step 3: Copy over JackKnife to enable modules use
* As JackKnife is in need to use modules from the Main script you have to send it over to the remote host as a .zip file. The Main script will check if it exists and create the folders necessary to use the modules. Please note that when you download JackKnife you will have to unzip it and also re-zip it to then use it remotely.
* #Command: Copy-Item -Path "C:\Users\$env:Username\Desktop\JackKnife.zip" -ToSession $Session -Destination "C:\Users\ "Remote User"\Desktop"
# Step 4: Invoking Commands to gather Data (Note: A module can only be ran once per Powershell window)
* #Command: Invoke-Command -Session $Session -Filepath "C:\Users\ "Your local Host Username"\Desktop\JackKnife\JackKnifeMain.ps1"
# Step 5: Cleanup
* Most hosts don't like it when we leave things on their computer, so after you've done all your modules you can then contain it all in one .zip file and copy it over to your computer. Here is a list of commands in order to use for cleaning up.(Note: This is within the same powershell window you invoked your command through)
* #Command: Invoke-Command -Session $Session {rm "C:\Users\$env:Username\Desktop\JackKnife.zip"}
* #Command: Invoke-Command -Session $Session {$dest=Read-Host "Give your host username" $file=Read-Host "Give a filename for your zip file" Compress-Archive -LiteralPath "C:\Users\$env:Username\Desktop\JackKnife" -DestinationPath "C:\Users\ $dest\Desktop\ $file"
* #Command:Invoke-Command -Session $Session {rmdir "C:\Users\ $env:Username\Desktop\JackKnife"}
* #Command: Remove-PsSession $Session




