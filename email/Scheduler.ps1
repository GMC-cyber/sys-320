function ChooseTimeToRun($Time){
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -like "myTask" }

    if($scheduledTasks -ne $null){
        Write-Host "The task already exists." | Out-String
        DisableAutorun
    }
        Write-Host "Creating new task." | Out-String

        $action = New-ScheduledTaskAction -Execute "powershell.exe" -argument "-File `".\main for Schedulued Email Reports.ps1`""
       
       
        $trigger = New-ScheduledTaskTrigger  -At $Time
        $principal = New-ScheduledTaskPrincipal -UserId "Grant Chandler" -RunLevel Highest
        $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
        $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
        Register-ScheduledTask  'myTask' -InputObject $task
            #-User "SYSTEM" -Settings (New-ScheduledTaskSettingsSet) 
           

        Get-ScheduledTask | Where-Object { $_.TaskName –like “myTask” }
    }

function DisableAutorun(){
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_. TaskName –like “my Task” }

    if($scheduledTasks –ne $null){
        Write-host “Unregistering the task.” | Out-string
        Unregister-scheduledtask –taskname “mytask” –confirm:$false
    } else {
         Write-host “The task is not registered.” | Out-string
}
}

