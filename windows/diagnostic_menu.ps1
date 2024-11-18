<#
.SYNOPSIS
    Diagnostic Tool Menu for Windows
.DESCRIPTION
    Provides an interactive menu for users to choose diagnostic tasks.
.NOTES
    Run this script with PowerShell as Administrator.
#>

# Log File
$LogFile = "..\shared\logs\diagnostic_menu_windows_$(Get-Date -Format yyyyMMdd_HHmmss).log"

# Function to log output
function Log {
    param (
        [string]$Message
    )
    $Message | Tee-Object -FilePath $LogFile -Append
}

# Function to display the main menu
function Display-Menu {
    Log "======================================="
    Log "      Diagnostic Tool Main Menu        "
    Log "======================================="
    Log ""
    Log "1) Run Full Diagnostics"
    Log "2) CPU, Memory, and Disk Usage"
    Log "3) Network Diagnostics"
    Log "4) Error Logs"
    Log "5) Advanced Tools"
    Log "6) Exit"
}

# Function to handle advanced tools menu
function Run-Advanced-Tools {
    Log "======================================="
    Log "      Advanced Tools for Windows       "
    Log "======================================="
    Log "1) Battery Health Check"
    Log "2) Boot Time Analysis"
    Log "3) Network Performance"
    Log "4) Storage Health"
    Log "5) Security Check"
    Log "6) Back to Main Menu"

    $AdvancedChoice = Read-Host "Enter your choice [1-6]"

    switch ($AdvancedChoice) {
        "1" {
            Log "Running Battery Health Check..."
            ./advanced/battery_check.ps1
        }
        "2" {
            Log "Running Boot Time Analysis..."
            ./advanced/boot_analysis.ps1
        }
        "3" {
            Log "Running Network Performance..."
            ./advanced/network_performance.ps1
        }
        "4" {
            Log "Running Storage Health..."
            ./advanced/storage_health.ps1
        }
        "5" {
            Log "Running Security Check..."
            ./advanced/security_check.ps1
        }
        "6" {
            Log "Returning to Main Menu."
        }
        default {
            Log "Invalid option. Please try again."
        }
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
                    Log "Running Full Diagnostics..."
                    ./diagnostic.ps1
                }
            }
            "2" {
                if (Confirm-Action "This script will analyze CPU, Memory, and Disk Usage.") {
                    Log "Running CPU, Memory, and Disk Usage Diagnostics..."
                    ./advanced/boot_analysis.ps1
                }
            }
            "3" {
                if (Confirm-Action "Network Diagnostics may temporarily interfere with ongoing connections.") {
                    Log "Running Network Diagnostics..."
                    ./advanced/network_performance.ps1
                }
            }
            "4" {
                Log "Fetching Error Logs..."
                ./advanced/security_check.ps1
            }
            "5" {
                Log "Opening Advanced Tools..."
                Run-Advanced-Tools
            }
            "6" {
                Log "Exiting the Diagnostic Tool."
                break
            }
            default {
                Log "Invalid option. Please try again."
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

# Run the menu
Log "Starting Diagnostic Tool Menu for Windows - $(Get-Date)"
Run-Menu
