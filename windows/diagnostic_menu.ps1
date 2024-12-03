<#
.SYNOPSIS
    Diagnostic Tool Menu for Windows
.DESCRIPTION
    Provides an interactive menu for users to choose diagnostic tasks.
.NOTES
    Run this script with PowerShell as Administrator.
#>

# Function to display the "p1x3l.push3r" ASCII art at the start
function Display-ASCII-Art {
    $asciiArt = @"
    ____  _     _               _____         __       
   |  _ \() __| | ___ _ __ ___|  __ \ /\    / _| ___ 
   | |_) | |/ _` |/ _ \ '__/ _ \ |__) /  \  | |_ / _ \
   |  __/| | (_| |  __/ | |  __/  __/ /\  |  _|  __/
   |_|   |_|\__,_|\___|_|  \___|_|  /_/  \_|_|  \___|
                                                       
  _________.__                   .___      __        .__  __  __   
 /   _____/|__| ____   ____ ___.__.\__|____|  |__    |__|/  \/  \  
 \_____  \ |  |/ ___\_/ __ <   |  | |  |/ __ |  |  \   |  |>    <   
 /        \|  \  \___ \  ___/___|  | |  \  ___|  |   \__|/   /\   \ 
/_______  /|__|\___  >\___  >   |__| |__|\___|__|   |  /__/\_/  /    
        \/      /   \/    \/                   \/   \/           
"@
    Write-Host $asciiArt -ForegroundColor Cyan
}

# Function to display the main menu
function Display-Menu {
    Write-Host "======================================="
    Write-Host "      Diagnostic Tool Main Menu        "
    Write-Host "======================================="
    Write-Host ""
    Write-Host "1) Run Full Diagnostics"
    Write-Host "2) CPU, Memory, and Disk Usage"
    Write-Host "3) Network Diagnostics"
    Write-Host "4) Error Logs"
    Write-Host "5) Advanced Tools"
    Write-Host "6) Exit"
}

# Function to handle advanced tools menu
function Run-Advanced-Tools {
    Write-Host "======================================="
    Write-Host "      Advanced Tools for Windows       "
    Write-Host "======================================="
    Write-Host "1) Battery Health Check"
    Write-Host "2) Boot Time Analysis"
    Write-Host "3) Network Performance"
    Write-Host "4) Storage Health"
    Write-Host "5) Security Check"
    Write-Host "6) Back to Main Menu"

    $AdvancedChoice = Read-Host "Enter your choice [1-6]"

    switch ($AdvancedChoice) {
        "1" { Write-Host "Running Battery Health Check..."; ./advanced/battery_check.ps1 }
        "2" { Write-Host "Running Boot Time Analysis..."; ./advanced/boot_analysis.ps1 }
        "3" { Write-Host "Running Network Performance..."; ./advanced/network_performance.ps1 }
        "4" { Write-Host "Running Storage Health..."; ./advanced/storage_health.ps1 }
        "5" { Write-Host "Running Security Check..."; ./advanced/security_check.ps1 }
        "6" { Write-Host "Returning to Main Menu." }
        default { Write-Host "Invalid option. Please try again." }
    }
}

# Main menu execution
function Run-Menu {
    while ($true) {
        Display-Menu
        $Choice = Read-Host "Enter your choice [1-6]"

        switch ($Choice) {
            "1" {
                if (Confirm-Action "Running Full Diagnostics for Windows will analyze all system resources and may take some time.") {
                    Write-Host "Running Full Diagnostics..."
                    ./diagnostic.ps1
                }
            }
            "2" {
                if (Confirm-Action "This script will analyze CPU, Memory, and Disk Usage.") {
                    Write-Host "Running CPU, Memory, and Disk Usage Diagnostics..."
                    ./advanced/boot_analysis.ps1
                }
            }
            "3" {
                if (Confirm-Action "Network Diagnostics may temporarily interfere with ongoing connections.") {
                    Write-Host "Running Network Diagnostics..."
                    ./advanced/network_performance.ps1
                }
            }
            "4" {
                Write-Host "Fetching Error Logs..."
                ./advanced/security_check.ps1
            }
            "5" {
                Write-Host "Opening Advanced Tools..."
                Run-Advanced-Tools
            }
            "6" {
                Write-Host "Exiting the Diagnostic Tool."
                return  # Use return to exit the function and stop the script.
            }
            default {
                Write-Host "Invalid option. Please try again."
            }
        }
    }
}


# Function to prompt for user confirmation
function Confirm-Action {
    param (
        [string]$ActionDescription
    )

    Write-Host ""
    Write-Host "WARNING: $ActionDescription" -ForegroundColor Yellow
    $response = Read-Host "Do you want to proceed? (yes/no)"
    if ($response -notmatch "^(yes|y)$") {
        Write-Host "Action canceled." -ForegroundColor Red
        return $false
    }
    return $true
}

# Display ASCII Art
Display-ASCII-Art

# Run the menu
Run-Menu