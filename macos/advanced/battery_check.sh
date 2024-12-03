#!/bin/zsh
# Battery Health Check Script

# Determine the base directory of the project
BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/battery_check_$(date +%Y%m%d_%H%M%S).log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== BATTERY HEALTH CHECK ==="

# Fetch battery information
log "Battery Information:"
pmset -g batt | tee -a "$LOG_FILE"
ioreg -l | grep -i "cycle count" | tee -a "$LOG_FILE"
ioreg -l | grep -i "battery health" | tee -a "$LOG_FILE"

log "Battery health check completed. Logs saved to $LOG_FILE."
