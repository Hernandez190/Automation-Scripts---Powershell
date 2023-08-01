#TurnOnWinRM
#Use Case: Script to turn on winrm service on endpoints. 
#Let's make sure that the powershell version is the Desktop version and not core or we will have issues. 

if ($PSEdition -eq 'Desktop'){

    Write-Host -ForegroundColor Yellow "PS Version is the correct edition. Proceeding now!"

}

else { 

    Write-Host -ForegroundColor Yellow "Not the correct PS version. Exiting now!"

        Start-Sleep 2

    Exit

}
    
##############################################################################
$name = Read-Host "What is the hostname of workstation we are turning on the service for?"
##############################################################################
$testtcpconnection = Test-NetConnection -ComputerName $name -Port 5985 -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
##############################################################################
$testpingconnection = Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue
##############################################################################

if ($testtcpconnection.TcpTestSucceeded -eq $true){

    Write-Host -ForegroundColor Yellow "WinRM service is up and running" 
    Write-Host -ForegroundColor Yellow "Exiting Now"

        Start-Sleep -Seconds 10

} 


elseif ($testtcpconnection.PingSucceeded -eq $true -and $testtcpconnection.TcpTestSucceeded -eq $false){

    Write-Host -ForegroundColor Yellow "Host is up, but WinRM is not enabled. Will try to turn it on now!"

        Start-Sleep -Seconds 10

            Set-Service -Name WinRM -ComputerName $name -Status Running -StartupType Automatic

    Write-Host -ForegroundColor Yellow "Winrm is now running!"

        Start-Sleep -Seconds 10

}

###############################################################################

elseif ($testtcpconnection.PingSucceeded -eq $false){

    Write-Host -ForegroundColor Yellow "Host is not reachable. Make sure it is turned on and connected to the network!"
    Write-Host -ForegroundColor Yellow "Exiting now"

        Start-Sleep -Seconds 10 

}   2>$null
