#!/bin/zsh
# System Integrity Check Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/integrity_check_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== SYSTEM INTEGRITY CHECK ==="

# Verify disk permissions
log "Verifying Disk Permissions:"
diskutil verifyPermissions / | tee -a "$LOG_FILE"

# System files integrity
log "\nVerifying System Files Integrity:"
sudo /usr/sbin/spctl --assess --type exec -v /usr/bin/* | tee -a "$LOG_FILE"

log "System integrity check completed. Logs saved to $LOG_FILE."
