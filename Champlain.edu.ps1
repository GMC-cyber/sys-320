$chromeProcess = Get-Process -Name chrome -ErrorAction SilentlyContinue
if ($chromeProcess) {
     # If Chrome is running, stop it
     Stop-Process -Name chrome -Force
     Write-Host "Google Chrome was running and has been stopped."
 } else {
     # If Chrome is not running, start it and navigate to Champlain.edu
     Start-Process "chrome.exe" "https://www.champlain.edu"
     Write-Host "Google Chrome was not running and has been started, directing to Champlain.edu."
 }
