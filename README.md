# JackKnife
JackKnife is a Network Defense Tool Repository for Powershell. It is made up of one main script and multiple modules built within. JackKnife is currently in development and new material will be added when updated. Works on Powershell 3.0 and up. The idea and point of JackKnife is to have a huge repository of Network and Host analytical tools in one script and in one source of access.
Windows Remote Management(WINRM) is neccessary to run the main script and its modules, however I am currently in the process on making the modules run as well as the main script.JackKnife is also currently in the process of finishing its WINRM Module.
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
