#!/bin/zsh

# Output log file
LOG_FILE="../shared/logs/diagnostic_macos_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start diagnostics
log "Starting macOS Diagnostics - $(date)"
log "===================================\n"

# System Information
log "=== SYSTEM INFORMATION ==="
log "Hostname: $(hostname)"
log "System Version: $(sw_vers)"
log "Kernel Version: $(uname -r)"
log "Uptime: $(uptime)"
log "Machine Architecture: $(uname -m)"
log "Hardware Overview:"
system_profiler SPHardwareDataType | tee -a "$LOG_FILE"

# CPU and Memory Usage
log "\n=== CPU AND MEMORY USAGE ==="
log "CPU Usage:"
top -l 1 | grep "CPU usage" | tee -a "$LOG_FILE"
log "Memory Usage:"
vm_stat | tee -a "$LOG_FILE"

# Disk Space
log "\n=== DISK SPACE ==="
df -h | tee -a "$LOG_FILE"

# Startup Items
log "\n=== STARTUP PROGRAMS ==="
osascript -e 'tell application "System Events" to get the name of every login item' | tee -a "$LOG_FILE"

# Network Diagnostics
log "\n=== NETWORK DIAGNOSTICS ==="
log "Ping Test to Google:"
ping -c 4 google.com | tee -a "$LOG_FILE"
log "Open Network Connections:"
lsof -i | grep ESTABLISHED | tee -a "$LOG_FILE"

# Error Logs
log "\n=== SYSTEM ERROR LOGS ==="
log "Fetching last 10 errors from system logs:"
log show --predicate 'eventMessage contains "error"' --info --style syslog --last 1d | tail -n 10 | tee -a "$LOG_FILE"

# Hardware Information
log "\n=== HARDWARE INFORMATION ==="
log "Thermal Status:"
pmset -g thermlog | tee -a "$LOG_FILE"

log "\n=== PERIPHERAL DEVICES ==="
system_profiler SPUSBDataType | tee -a "$LOG_FILE"

# Software Updates
log "\n=== SOFTWARE UPDATES ==="
log "Checking for available updates:"
softwareupdate -l | tee -a "$LOG_FILE"

# Installed Applications
log "\n=== INSTALLED APPLICATIONS ==="
log "Listing all installed applications:"
ls /Applications | tee -a "$LOG_FILE"

# End diagnostics
log "\nDiagnostics completed. Logs saved to $LOG_FILE"
echo "Diagnostics completed. Logs saved to $LOG_FILE"
