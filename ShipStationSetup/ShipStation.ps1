<#
SYNOPSYS
This script will create a ship station when the script is run

DESCRITPION
The below script will copy GetScale the SKSNA01 drive, create the proper registry in the HKEY_LOCAL_MACHINE with the proper path, then will install
the Connect ship program in the proper order

NOTES
File name:  ShipStation.ps1
Author:     Justin Neubauer
#>


<# This tests the path, If the path is correct then this is will move on to the installation part of the script. #>
if (
  test-path "\\sksna01\software\standalone\ship station\" )

 {

<# This copies GetScale.exe from \\SKSNA01\Software\Standalone\Ship Station\GetScale.exe and places it in the C:\ directory #>
Copy-Item '\\SKSNA01\Software\Standalone\Ship Station\GetScale.exe' -destination C:\ ;
<# This creates a string in the registry where GetScale.exe executes on startup #>
New-Itemproperty -path HKLM:\software\Microsoft\Windows\CurrentVersion\run -name "GetScale" -type "string" -value C:\GetScale.exe -force;
<# This installs Connect Ship on the computer#>
& '\\SKSNA01\Software\Standalone\Ship Station\ConnectShipToolkitClientSetup-6.5.exe' |
<# This installs Core-C on the computer#>
& '\\SKSNA01\Software\Standalone\Ship Station\UpdateInstaller-6.5-Core-C.exe' |
<# This installs Library on the computer#>
& '\\SKSNA01\Software\Standalone\Ship Station\UpdateInstaller-6.5-COM-Typelib-A.exe' |

<# Waits 0 Seconds after initializing the installer for the library before executing the next command #>
Start-Sleep -s 0;
<# The next two lines produces an output box #> 
$wshell1 = New-Object -ComObject Wscript.Shell 
$wshell1.Popup("To complete the installation of GetScale.exe, your computer must be restarted",0,"Setup Complete", 64)}



<# this will run if the path is incorrect #>
else {
$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
$wshell.Popup("You did not enter the path correctly",0,"Done", 48)}



