#!/bin/zsh
# Security Check Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/storage_health_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== SECURITY CHECK ==="

# Firewall status
log "Firewall Status:"
defaults read /Library/Preferences/com.apple.alf globalstate | tee -a "$LOG_FILE"

# Gatekeeper status
log "Gatekeeper Status:"
spctl --status | tee -a "$LOG_FILE"

# SIP (System Integrity Protection) status
log "System Integrity Protection (SIP) Status:"
csrutil status | tee -a "$LOG_FILE"

log "Security check completed. Logs saved to $LOG_FILE."
