#!/bin/zsh

# Load animations from the external file
source ./animations.sh

# Output log file
LOG_FILE="../shared/logs/diagnostic_macos_$(date +%Y%m%d_%H%M%S).log"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Display ASCII art and countdown
clear
display_ascii_art
countdown 1
log "Starting macOS Diagnostics - $(date)"
log "===================================\n"

# System Information
echo "Collecting System Information..."
progress_bar 5
log "=== SYSTEM INFORMATION ==="
{
    echo "Hostname: $(hostname)"
    echo "System Version: $(sw_vers)"
    echo "Kernel Version: $(uname -r)"
    echo "Uptime: $(uptime)"
    echo "Machine Architecture: $(uname -m)"
    echo "Hardware Overview:"
    system_profiler SPHardwareDataType
} | tee -a "$LOG_FILE"
sleep 1

# CPU and Memory Usage
echo "Analyzing CPU and Memory Usage..."
spinner "Analyzing CPU and Memory Usage" &
log "\n=== CPU AND MEMORY USAGE ==="
{
    echo "CPU Usage:"
    top -l 1 | grep "CPU usage"
    echo "Memory Usage:"
    vm_stat
} | tee -a "$LOG_FILE"
kill $! 2>/dev/null
sleep 1

# Disk Space
echo "Checking Disk Space..."
progress_bar 3
log "\n=== DISK SPACE ==="
df -h | tee -a "$LOG_FILE"
sleep 1

# Startup Items - Login
echo "Fetching Startup Programs..."
spinner "Fetching Startup Programs" &
log "\n=== STARTUP PROGRAMS ==="
osascript -e 'tell application "System Events" to get the name of every login item' | tee -a "$LOG_FILE"
kill $! 2>/dev/null
sleep 1

# Network Diagnostics
echo "Running Network Diagnostics..."
progress_bar 4
log "\n=== NETWORK DIAGNOSTICS ==="
{
    echo "Ping Test to Google:"
    ping -c 4 google.com
    echo "Open Network Connections:"
    lsof -i | grep ESTABLISHED
} | tee -a "$LOG_FILE"
sleep 1

# Error Logs
echo "Retrieving System Error Logs..."
spinner "Retrieving System Error Logs" &
log "\n=== SYSTEM ERROR LOGS ==="
log show --predicate 'eventMessage contains "error"' --info --style syslog --last 1d | tail -n 10 | tee -a "$LOG_FILE"
kill $! 2>/dev/null
sleep 1

# Events from Last 30 Days
echo "Fetching System Events from Last 30 Days..."
spinner "Fetching System Events" &
log "\n=== EVENTS FROM LAST 30 DAYS ==="

# Critical Events
log "Critical Events:"
critical_events=$(log show --predicate 'eventMessage contains "critical"' --info --style syslog --last 30d)
if [ -z "$critical_events" ]; then
    log "No critical events found."
else
    echo "$critical_events" | tee -a "$LOG_FILE"
fi

# High Severity Events
log "\nHigh Severity Events:"
high_severity_events=$(log show --predicate 'eventMessage contains "error"' --info --style syslog --last 30d)
if [ -z "$high_severity_events" ]; then
    log "No high severity events found."
else
    echo "$high_severity_events" | tee -a "$LOG_FILE"
fi

# Warnings
log "\nWarnings:"
warnings=$(log show --predicate 'eventMessage contains "warning"' --info --style syslog --last 30d)
if [ -z "$warnings" ]; then
    log "No warnings found."
else
    echo "$warnings" | tee -a "$LOG_FILE"
fi
kill $! 2>/dev/null
sleep 1

# Software Updates
echo "Checking for Software Updates..."
progress_bar 3
log "\n=== SOFTWARE UPDATES ==="
softwareupdate -l | tee -a "$LOG_FILE"
sleep 1

# Installed Applications
echo "Listing Installed Applications..."
spinner "Listing Installed Applications" &
log "\n=== INSTALLED APPLICATIONS ==="
ls /Applications | tee -a "$LOG_FILE"
kill $! 2>/dev/null
sleep 1

# End diagnostics
echo "Completing Diagnostics..."
progress_bar 2
log "\nDiagnostics completed. Logs saved to $LOG_FILE"
echo -e "\033[0;32mDiagnostics completed. Logs saved to $LOG_FILE\033[0m"
