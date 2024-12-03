#!/bin/zsh
# Network Performance Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/network_performance_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== NETWORK PERFORMANCE ==="

# Ping test
log "Ping Test to Google:"
ping -c 4 google.com | tee -a "$LOG_FILE"

# Download and upload speed test (requires `speedtest-cli`)
if command -v speedtest >/dev/null 2>&1; then
    log "Speed Test Results:"
    speedtest | tee -a "$LOG_FILE"
else
    log "speedtest-cli is not installed. Skipping speed test."
fi

log "Network performance analysis completed. Logs saved to $LOG_FILE."
