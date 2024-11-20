. (Join-Path $PSScriptRoot "Emailer.ps1")
. (Join-Path $PSScriptRoot "Event-Logs.ps1")
. (Join-Path $PSScriptRoot "Scheduler.ps1")


if (Test-Path -Path "./configuration.txt") {
        $config = Get-Content -Path "./configuration.txt" | ConvertFrom-Json}


$d =  $config.Days
$userLogins = getFailedLogins $d
$R = "All users are suspicious" #$userLogins | group-Object User | where-object{$_count -ge 3} | Format-Table | Out-String
         SendAlertEmail($R)

ChooseTimeToRun($config.ExecutionTime)
