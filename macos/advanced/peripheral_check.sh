#!/bin/zsh
# Peripheral Devices Check Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/peripheral_check_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== PERIPHERAL DEVICES ==="

# USB devices
log "Connected USB Devices:"
system_profiler SPUSBDataType | tee -a "$LOG_FILE"

# Thunderbolt devices
log "\nConnected Thunderbolt Devices:"
system_profiler SPThunderboltDataType | tee -a "$LOG_FILE"

log "Peripheral devices check completed. Logs saved to $LOG_FILE."
