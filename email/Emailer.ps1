function SendAlertEmail($body){
    $from = "grant.chandler@mymail.champlain.edu"
    $to = "grant.chandler@mymail.champlain.edu"
    $subject = "Suspicious Activity"
    
    $password = "rsdw bhpj mfmy usdj" | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $from, $password
    
    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer "smtp.gmail.com" `
    -port 587 -UseSsl -Credential $credential
}


