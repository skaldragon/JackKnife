# JackKnife
JackKnife is a Network Defense Tool Repository for Powershell. It contains multiple Powershell Scripts that I've made and or borrowed. Anything I've borrowed will be cited and given credit to the original owners. JackKnife is in a revamp stage and most old modules/scripts will be replaced with newer and better working scripts.
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

# JackKnife Version 3.0.1
* Added Tools Repository with scripts to help and guide operations
* Encrypter and Decrypter files added to tool set
* Send-File was added thanks to adbertram @https://github.com/adbertram/Random-PowerShell-Work
# JackKnife Version 3.1.0
* New Get-Stream File updated and renewed for ADS streams
* New Persist-Action added for persistent information grabbing on the fly!
* Removed prior steps for using jackknifemain.ps1 since now this will just be a tool repository with details on tools added to JackKnife.
# JackKnife Version 3.2.0
* Added Get-ProcessModuleInfo for modules associated with running services and detailed information about those modules
# JackKnife Version 3.3.0
* Added Get-ComputerInformation for computer forensics searching
* Fixed Search-File to work correctly for all hosts on a domain and local hosts!
# JackKnife Version 3.3.1
* Added Get-Drivers for kernel Driver enumeration.
# JackKnife Version 3.3.2
* Added Get-BetterNetstat to allow users to get Netstat information and Process ownership without the need to be Administrator

