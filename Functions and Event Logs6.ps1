. .\Untitled3.ps1

clear

$ErrorActionPreference = "SilentlyContinue"

$loginoutstable = Get-LoginLogoutEvents -DaysOffset 15
$loginoutstable

$Shutdowntable = Get-StartupShutdownEvents -DaysOffset 25 -EventType "Shutdown"
$Shutdowntable

$Startuptable = Get-StartupShutdownEvents -DaysOffset 25 -EventType "Startup"
$Startuptable
