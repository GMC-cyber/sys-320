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
Get-LoginLogoutEvents -DaysOffset 4
