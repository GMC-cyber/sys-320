
function readConfiguration {
    if (Test-Path -Path "./configuration.txt") {
        $config = Get-Content -Path "./configuration.txt" | ConvertFrom-Json
        [PSCustomObject]@{
            Days = $config.Days
            ExecutionTime = $config.ExecutionTime
        }
    } else {
        Write-Host "Configuration file not found."
    }
}


function changeConfiguration {
    $days = Read-Host "Enter the number of days (digits only)"
    while ($days -notmatch '^\d+$') {
        $days = Read-Host "Invalid input. Enter the number of days (digits only)"
    }

    $executionTime = Read-Host "Enter the execution time (format: HH:MM AM/PM)"
    while ($executionTime -notmatch '^\d{1,2}:\d{2} (AM|PM)$') {
        $executionTime = Read-Host "Invalid input. Enter the execution time (format: HH:MM AM/PM)"
    }

    $config = @{
        Days = $days
        ExecutionTime = $executionTime
    }

    $config | ConvertTo-Json | Set-Content -Path "./configuration.txt"
    Write-Host "Configuration updated successfully."
}


function configurationMenu {
    do {
        Clear-Host
        Write-Host "================ Configuration Menu ================"
        Write-Host "1: Show configuration"
        Write-Host "2: Change configuration"
        Write-Host "3: Exit"
        $selection = Read-Host "Please make a selection (1, 2, or 3)"

        switch ($selection) {
            '1' { readConfiguration }
            '2' { changeConfiguration }
            '3' { Write-Host "Exiting..."; break }
            default { Write-Host "Invalid selection. Please choose 1, 2, or 3." }
        }
        Pause
    } while ($selection -ne '3')
}


configurationMenu