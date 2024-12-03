#!/bin/bash

# Function to display the main menu
display_menu() {
    echo "======================================="
    echo "      Diagnostic Tool Main Menu        "
    echo "======================================="
    echo ""
    echo "1) Run Full Diagnostics"
    echo "2) Advanced Tools"
    echo "3) Exit"
}

run_advanced_tools() {
    echo "======================================="
    echo "      Advanced Tools for macOS         "
    echo "======================================="
    echo "1) CPU, Memory, and Disk Usage"
    echo "2) Network Diagnostics"
    echo "3) Error Logs"
    echo "4) Battery Health Check"
    echo "5) Boot Time Analysis"
    echo "6) Network Performance"
    echo "7) Storage Health"
    echo "8) Security Check"
    echo "9) Thermal Status Check"
    echo "10) Peripheral Devices"
    echo "11) System Integrity Check"
    echo "12) Application Resource Usage"
    echo "13) Event Log Categorization"
    echo "14) File System Usage"
    echo "15) Software Version Check"
    echo "16) Back to Main Menu"

    read -p "Enter your choice [1-16]: " ADV_CHOICE

    case $ADV_CHOICE in
        1)
            ./advanced/storage_health.sh
            ;;
        2)
            ./advanced/network_performance.sh
            ;;
        3)
            ./advanced/security_check.sh
            ;;
        4)
            ./advanced/battery_check.sh
            ;;
        5)
            ./advanced/boot_analysis.sh
            ;;
        6)
            ./advanced/network_performance.sh
            ;;
        7)
            ./advanced/storage_health.sh
            ;;
        8)
            ./advanced/security_check.sh
            ;;
        9)
            ./advanced/thermal_check.sh
            ;;
        10)
            ./advanced/peripheral_check.sh
            ;;
        11)
            ./advanced/integrity_check.sh
            ;;
        12)
            ./advanced/app_resource_usage.sh
            ;;
        13)
            ./advanced/event_log_analysis.sh
            ;;
        14)
            ./advanced/filesystem_usage.sh
            ;;
        15)
            ./advanced/software_version_check.sh
            ;;
        16)
            echo "Returning to Main Menu."
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Main menu execution
run_menu() {
    while true; do
        display_menu
        read -p "Enter your choice [1-3]: " CHOICE

        case $CHOICE in
            1)
                echo "Running Full Diagnostics..."
                ./diagnostic.sh
                ;;
            2)
                echo "Opening Advanced Tools..."
                run_advanced_tools
                ;;
            3)
                echo "Exiting the Diagnostic Tool."
                exit 0
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done
}

# Run the menu
echo "Starting Diagnostic Tool Menu for macOS - $(date)"
run_menu
