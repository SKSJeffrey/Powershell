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

<# This copies GetScale.exe from \\SKSNA01\Software\Standalone\Ship Station\GetScale.exe and places it in the C:\ directory #>
Copy-Item '\\SKSNA01\Software\Standalone\Ship Station\GetScale.exe' -destination C:\ ;
<# This creates a string in the registry where GetScale.exe executes on startup #>
New-Itemproperty -path HKLM:\software\Microsoft\Windows\CurrentVersion\run -name "GetScale" -type "string" -value C:\GetScale.exe |
<# This installs Connect Ship on the computer#>
& '\\SKSNA01\Software\Standalone\Ship Station\ConnectShipToolkitClientSetup-6.5.exe' -s|
<# This installs Core-C on the computer#>
& '\\SKSNA01\Software\Standalone\Ship Station\UpdateInstaller-6.5-Core-C.exe' |
<# This installs Library on the computer#>
& '\\SKSNA01\Software\Standalone\Ship Station\UpdateInstaller-6.5-COM-Typelib-A.exe' |

<# Waits 20 Seconds after initializing the installer for the library before executing the next command #>
Start-Sleep -s 0;
<# The next two lines produces an output box #> 
$wshell1 = New-Object -ComObject Wscript.Shell
$wshell1.Popup("You must Restart the Computer for GetScale to work!",0,"Done");

<# Error Handling:

Common Errors you might find

New-Itemproperty : The property already exists.
At C:\Users\Justin Neubauer\Documents\Powershell Scripts\ShipStation.ps1:16 char:1
+ New-Itemproperty -path HKLM:\software\Microsoft\Windows\CurrentVersion\run -name ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ResourceExists: (HKEY_LOCAL_MACH...rentVersion\run:String) [New-ItemProperty], IOException
    + FullyQualifiedErrorId : System.IO.IOException,Microsoft.PowerShell.Commands.NewItemPropertyCommand
    IF you find this error, then the HKEY was already placed int he proper section.#>