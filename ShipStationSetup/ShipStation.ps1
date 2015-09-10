<#
SYNOPSIS
Installs the necessary components for a functional Ship Station

NOTES
File name:  ShipStation.ps1
Created by: Justin Neubauer
Edited by:	Jeffrey Wen
#>

<# Directory exists #>
if ( Test-Path "\\sksna01\Software\Standalone\Ship Station\" )
{
		<# Copy GetScale.exe to client computer #>
		Copy-Item "\\sksna01\Software\Standalone\Ship Station\GetScale.exe" -Destination C:\

		<# Enable GetScale.exe to start on boot #>
		New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name GetScale -PropertyType String -Value C:\GetScale.exe -Force

		<# Install ConnectShip Client, Core-C, and COM libraries #>
		Start-Process "\\sksna01\Software\Standalone\Ship Station\ConnectShipToolkitClientSetup-6.5.exe"
		Start-Process "\\sksna01\Software\Standalone\Ship Station\UpdateInstaller-6.5-Core-C.exe"
		Start-Process "\\sksna01\Software\Standalone\Ship Station\UpdateInstaller-6.5-COM-Typelib-A.exe"

		<# Create popup to indicate completion #>
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Restart your computer to complete the installation.", 0, "Setup Complete", 64)
}

<# Directory DNE #>
else {
	<# Create popup to indicate failure #>
		$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
		$wshell.Popup("Ship Station directory does not exist.", 0, "Done", 48)
}
