#!/bin/zsh
# Thermal Status Check Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/thermal_check_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== THERMAL STATUS CHECK ==="

# Thermal status
log "Current Thermal Status:"
pmset -g thermlog | tee -a "$LOG_FILE"

log "Thermal status check completed. Logs saved to $LOG_FILE."