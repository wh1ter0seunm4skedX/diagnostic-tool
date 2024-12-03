#!/bin/zsh
# Event Log Categorization Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/event_log_analysis_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== EVENT LOG CATEGORIZATION ==="

# Critical events
log "\nCritical Events (Last 30 Days):"
log show --predicate 'eventMessage contains "critical"' --info --style syslog --last 30d | tee -a "$LOG_FILE"

# High severity events
log "\nHigh Severity Events (Last 30 Days):"
log show --predicate 'eventMessage contains "error"' --info --style syslog --last 30d | tee -a "$LOG_FILE"

# Medium severity events
log "\nMedium Severity Events (Last 30 Days):"
log show --predicate 'eventMessage contains "warning"' --info --style syslog --last 30d | tee -a "$LOG_FILE"

log "Event log categorization completed. Logs saved to $LOG_FILE."
