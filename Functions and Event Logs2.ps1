$loginouts = Get-EventLog -LogName system -Source Microsoft-Windows-Winlogon -After(Get-Date).AddDays(-14)

$loginoutstable = @()
for($i=0; $i -lt $loginouts.count; $i++){
$event = ""

if ($loginouts[$i].InstanceId -eq "7001") {$event = "Logon"}
if ($loginouts[$i].InstanceId -eq "7002") {$event = "Logofff"}

$user = $loginouts[$i].ReplacementStrings[1]

$loginoutstable  += [pscustomobject] @{"Time"= $loginouts[$i].TimeGenerated;
                                       "id" = $loginouts[$i].InstanceID;
                                       "Event" = $event;
                                       "User" = $user;}
}
$loginoutstable
