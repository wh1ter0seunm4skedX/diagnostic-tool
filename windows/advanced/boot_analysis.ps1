Write-Host "WARNING: This script will restart your computer to measure boot time." -ForegroundColor Yellow
$response = Read-Host "Do you want to proceed? (yes/no)"
if ($response -notmatch "^(yes|y)$") {
    Write-Host "Action canceled." -ForegroundColor Red
    return
}

# Proceed with boot analysis
Restart-Computer
