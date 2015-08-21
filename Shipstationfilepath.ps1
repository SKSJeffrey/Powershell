<# 
SYNOPSYS
This is a script to test the path of the first object then run a command 

DESCRIPTION
The below script tests the path to the shipstation folder on the "S: drive.  If the path is correct then;
the script executes the script listed.  If the path is not correct; a popup box appears.

NOTES
File name: ShipStationFilePath.ps1
Author:    Justin Neubauer
#>


<# This tests the path #>
if (
  test-path "\\sksna01\software\standalone\shipstation\" )


<# This will run if the path is correct #>
{ \\sksna01\software\standalone\powershellscripts\shipstation.ps1}

<# this will run if the path is incorrect #>
else {
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("You did not enter the path correctly",0,"Done")}

