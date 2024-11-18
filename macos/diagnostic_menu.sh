#!/bin/bash

# Log File
LOG_FILE="../shared/logs/diagnostic_menu_macos_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Function to display the main menu
display_menu() {
    log "======================================="
    log "      Diagnostic Tool Main Menu        "
    log "======================================="
    log ""
    log "1) Run Full Diagnostics"
    log "2) CPU, Memory, and Disk Usage"
    log "3) Network Diagnostics"
    log "4) Error Logs"
    log "5) Advanced Tools"
    log "6) Exit"
}

# Function to handle advanced tools menu
run_advanced_tools() {
    log "======================================="
    log "      Advanced Tools for macOS         "
    log "======================================="
    log "1) Battery Health Check"
    log "2) Boot Time Analysis"
    log "3) Network Performance"
    log "4) Storage Health"
    log "5) Security Check"
    log "6) Back to Main Menu"

    read -p "Enter your choice [1-6]: " ADV_CHOICE

    case $ADV_CHOICE in
        1)
            log "Running Battery Health Check..."
            sudo ./advanced/battery_check.sh
            ;;
        2)
            log "Running Boot Time Analysis..."
            sudo ./advanced/boot_analysis.sh
            ;;
        3)
            log "Running Network Performance..."
            sudo ./advanced/network_performance.sh
            ;;
        4)
            log "Running Storage Health..."
            sudo ./advanced/storage_health.sh
            ;;
        5)
            log "Running Security Check..."
            sudo ./advanced/security_check.sh
            ;;
        6)
            log "Returning to Main Menu."
            ;;
        *)
            log "Invalid option. Please try again."
            ;;
    esac
}

# Main menu execution
run_menu() {
    while true; do
        display_menu
        read -p "Enter your choice [1-6]: " CHOICE

        case $CHOICE in
            1)
                if confirm_action "Running Full Diagnostics for macOS will analyze all system resources and may take some time."; then
                    log "Running Full Diagnostics..."
                    sudo ./diagnostic.sh
                fi
                ;;
            2)
                if confirm_action "This script will analyze CPU, Memory, and Disk Usage."; then
                    log "Running CPU, Memory, and Disk Usage Diagnostics..."
                    sudo ./advanced/storage_health.sh
                fi
                ;;
            3)
                if confirm_action "Network Diagnostics may temporarily interfere with ongoing connections."; then
                    log "Running Network Diagnostics..."
                    sudo ./advanced/network_performance.sh
                fi
                ;;
            4)
                log "Fetching Error Logs..."
                sudo ./advanced/security_check.sh
                ;;
            5)
                log "Opening Advanced Tools..."
                run_advanced_tools
                ;;
            6)
                log "Exiting the Diagnostic Tool."
                exit 0
                ;;
            *)
                log "Invalid option. Please try again."
                ;;
        esac
    done
}



# Function to prompt for user confirmation
confirm_action() {
    local action_description="$1"
    echo ""
    echo "WARNING: $action_description"
    read -p "Do you want to proceed? (yes/no): " response
    if [[ ! "$response" =~ ^(yes|y)$ ]]; then
        echo "Action canceled."
        return 1
    fi
    return 0
}

# Run the menu
log "Starting Diagnostic Tool Menu for macOS - $(date)"
run_menu
