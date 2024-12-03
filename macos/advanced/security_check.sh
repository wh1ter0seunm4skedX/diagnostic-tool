#!/bin/zsh
# Storage Health Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/security_check_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== STORAGE HEALTH ==="

# Disk information
log "Disk Information:"
diskutil list | tee -a "$LOG_FILE"

# Check SMART status
log "SMART Status:"
diskutil info / | grep SMART | tee -a "$LOG_FILE"

log "Storage health check completed. Logs saved to $LOG_FILE."
