***To import both Encrypter.ps1, Decrypter.ps1,and Send-File.ps1 make your way within your powershell console to this directory and input these commands:
Import-Module .\Encrypter.ps1
Import-Module .\Decrypter.ps1
Import-Module .\Send-File.ps1

# Encrypter and Decrypter
* Used to Encrypt and Decrypt your files with a 256 bit key for security and confidentiality in mind
* Able to Encrypt and Decrypt Remotely so that you can prevent knowledge of your hidden files
* Will pull secure key from Key.txt file, which can be modified and changed to however you want your key to be.

# Send-File.ps1
* Borrowed from Adbertram for use in this project, did initially have my own copyfile script but was restrained to data sizes.
* Please visit his page here https://github.com/adbertram/Random-PowerShell-Work

# Persist-Action.ps1
* Creates a persisting action on a local machine to gather computer data and save it on your local computer
* Network Connections, Processes, and log grabbing are the three main persistence actions it can do right now.
