#cat .\access.log
#cat .\access.log -Tail 5
#cat .\access.log | select-String ' 404 ' , ' 400 '
#cat .\access.log | select-String -Pattern "200" -NotMatch

#$a = cat .\*.log | select-String 'error'
#$a[-5..-1]
<#
$notfounds = Get-Content C:\xampp\apache\logs\access.log | select-String ' 404 '
$regex = [regex] "\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b"
$ipsUnorganized = $regex.Matches($notfounds)
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i] }

    }



    $ips = $ips | where-object { $_.IP -like "10.*" }
    $ips
#>
<#
$ipsoftens = $ips | Where-Object { $_.IP -like "10.*" }
$counts = $ipsoftens | group-object IP
$counts | Select-Object Count, Name
$counts

#>
<#
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
#>

#. .\Apache-Logs.ps1
#Get-ApacheLogIPs -Page "index.html" -HttpCode 200 
