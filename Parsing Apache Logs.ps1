function Get-ApacheLogIPs {
    param (
        [string]$Page,
        [int]$HttpCode,
        [string]$Browser
    )

   
    $logFilePath = "C:\xampp\apache\logs\access.log"

    $logEntries = Get-Content $logFilePath

   
    $filteredIPs = $logEntries | Where-Object {
        $_ -match $Page -and
        $_ -match $HttpCode -and
        $_ -match $Browser
    } | ForEach-Object {
        
        if ($_ -match '(\d{1,3}\.){3}\d{1,3}') {
            $matches[0]
        }
    }

    
    $uniqueIPs = $filteredIPs | Sort-Object -Unique

   
    return $uniqueIPs
}


# Example usage
<#
$Page = "index.html"
$HttpCode = 200
$Browser = "Mozilla"
$IPs = Get-ApacheLogIPs -Page $Page -HttpCode $HttpCode -Browser $Browser
$IPs
#>




function ApacheLogs1(){ 
$logsNotformatted = Get-Content C:\xampp\apache\logs\access.log 
$tableRecords = @()

for ($i=0; $i -lt $logsNotformatted.count ; $i++){

$words = $logsNotformatted[$i].Split(" ")

$tableRecords += [PSCustomObject] @{"IP" =$words[0];
                                    "Time" = $words[3].Trim('[');
                                    "Methhod" = $words[5].Trim('"');
                                    "Page" = $words[6];
                                    "Protocol" = $words[7];
                                    "Response" = $words[8];
                                    "Referrer" = $words[10];
                                    "Client" = $words[11..($words.LongLength)];
                                    }
}
return $tableRecords | Where-Object {$_.IP -like "10.*"}
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap

main.ps1
. .\Apache-Logs.ps1

#Get-ApacheLogIPs -Page "index.html" -HttpCode 200
ApacheLogs1 

