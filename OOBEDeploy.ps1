$Params = @{
    AddNetFX3 = $true
    RemoveAppx = "CommunicationsApps", "GetHelp", "Getstarted", "3DViewer", "People", "OfficeHub", "People", "Skype", "Solitaire", "Wallet", "windowscommunicationsapps", "WindowsFeedbackHub", "Xbox", "ZuneMusic", "ZuneVideo"
    UpdateDrivers = $true
    UpdateWindows = $true
}
Start-OOBEDeploy @Params

#Setup Administrator Account
"net user Administrator iR3rSITT3R /active:yes" | cmd
"wmic useraccount WHERE Name='Administrator' set PasswordExpires=false" | cmd

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

#User to search for
$USERNAME = "ITSupport"

#Declare LocalUser Object
$ObjLocalUser = $null

try
{
	Write-Verbose "Searching for $($USERNAME) in LocalUser DataBase"
	$ObjLocalUser = Get-LocalUser $USERNAME
	Write-Verbose "User $($USERNAME) was found"
}

catch [Microsoft.PowerShell.Commands.UserNotFoundException] {
	"User $($USERNAME) was not found" | Write-Warning
}
catch
{
	"An unspecifed error occured" | Write-Error
	Exit # Stop Powershell! 
}

#Update the user password
if ($ObjLocalUser)
{
	Write-Verbose "Updating User $($USERNAME)"
	#Update Local Support Account
	
	"net user ITSupport H3lpM3!!2022" | cmd
	"wmic useraccount WHERE Name='ITSupport' set PasswordExpires=false" | cmd
	Set-LocalUser -Description "Local Support Account" -Name "ITSupport"
	
}

#Create the user if it was not found
if (!$ObjLocalUser)
{
	Write-Verbose "Creating User $($USERNAME)"
	#Setup Local Support Account
	
	"net user ITSupport H3lpM3!!2022 /add /active:yes" | cmd
	"wmic useraccount WHERE Name='ITSupport' set PasswordExpires=false" | cmd
	Add-LocalGroupMember -Group "Power Users" -Member "ITSupport"
	Add-LocalGroupMember -Group "Network Configuration Operators" -Member "ITSupport"
	Set-LocalUser -FullName "ITSupport" -Description "Local Support Account" -Name "ITSupport"
}