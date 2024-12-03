#!/bin/zsh
# Software Version Check Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/software_version_check_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== SOFTWARE VERSION CHECK ==="

# List installed applications and their versions
log "Listing Installed Applications and Versions:"
for app in /Applications/*; do
    log "$(basename "$app"): $(defaults read "$app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || echo "Version info not found")"
done

log "Software version check completed. Logs saved to $LOG_FILE."
