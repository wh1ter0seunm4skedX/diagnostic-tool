#!/bin/zsh
# Boot Time Analysis Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/boot_analysis_$(date +%Y%m%d_%H%M%S).log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== BOOT TIME ANALYSIS ==="

# Fetch boot time
log "Last Boot Time:"
sysctl kern.boottime | tee -a "$LOG_FILE"

log "Boot time analysis completed. Logs saved to $LOG_FILE."
