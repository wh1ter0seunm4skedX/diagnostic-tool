#!/bin/zsh
# File System Usage Script

BASE_DIR=$(dirname "$(dirname "$(dirname "$0")")")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/filesystem_usage_$(date +%Y%m%d_%H%M%S).log"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Start logging
log "=== FILE SYSTEM USAGE ==="

# Disk space usage by directory
log "Disk Space Usage by Top Directories:"
du -sh /* 2>/dev/null | sort -rh | head -n 10 | tee -a "$LOG_FILE"

# Largest files in the system
log "\nLargest Files in the System:"
find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | tee -a "$LOG_FILE"

log "File system usage analysis completed. Logs saved to $LOG_FILE."
