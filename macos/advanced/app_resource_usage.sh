#!/bin/zsh
# Application Resource Usage Script

# Determine the base directory of the project
BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/app_resource_usage_$(date +%Y%m%d_%H%M%S).log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== APPLICATION RESOURCE USAGE ==="

# Top memory-consuming processes
log "Top Memory-Consuming Processes:"
ps aux | sort -nrk 4 | head -n 10 | tee -a "$LOG_FILE"

# Top CPU-consuming processes
log "\nTop CPU-Consuming Processes:"
ps aux | sort -nrk 3 | head -n 10 | tee -a "$LOG_FILE"

log "Application resource usage analysis completed. Logs saved to $LOG_FILE."
