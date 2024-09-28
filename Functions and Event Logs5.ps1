function Get-LoginLogoutEvents {
    param (
        [int]$DaysOffset = 14
    )

    $loginouts = Get-EventLog -LogName system -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$DaysOffset)

    $loginoutstable = @()
    for ($i = 0; $i -lt $loginouts.count; $i++) {
        $event = ""

        if ($loginouts[$i].InstanceId -eq 7001) { $event = "Logon" }
        if ($loginouts[$i].InstanceId -eq 7002) { $event = "Logoff" }

        $user = $loginouts[$i].ReplacementStrings[1]

        $SID = New-Object System.Security.Principal.SecurityIdentifier($user)
        $user = $SID.Translate([System.Security.Principal.NTAccount])

        $loginoutstable += [pscustomobject]@{
            "Time"  = $loginouts[$i].TimeGenerated
            "id"    = $loginouts[$i].InstanceID
            "Event" = $event
            "User"  = $user
        }
    }
    return $loginoutstable
}

# Example usage:
# Get-LoginLogoutEvents -DaysOffset 4

function Get-StartupShutdownEvents {
    param (
        [int]$DaysOffset = 14,
        [ValidateSet("Startup", "Shutdown", "Both")]
        [string]$EventType = "Both"
    )

    $eventIds = @()
    if ($EventType -eq "Startup" -or $EventType -eq "Both") {
        $eventIds += 6005
    }
    if ($EventType -eq "Shutdown" -or $EventType -eq "Both") {
        $eventIds += 6006
    }

    $events = Get-EventLog -LogName system -After (Get-Date).AddDays(-$DaysOffset) | Where-Object {
        $eventIds -contains $_.EventID
    }

    $eventstable = @()
    foreach ($event in $events) {
        $eventType = ""
        if ($event.EventID -eq 6005) { $eventType = "Startup" }
        if ($event.EventID -eq 6006) { $eventType = "Shutdown" }

        $eventstable += [pscustomobject]@{
            "Time"  = $event.TimeGenerated
            "Id"    = $event.EventID
            "Event" = $eventType
            "User"  = "System"
        }
    }
    return $eventstable
}

# Example usage:
Get-StartupShutdownEvents -DaysOffset 7 -EventType "Startup"
