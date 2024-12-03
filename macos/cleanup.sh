#!/bin/zsh

# Load animations
if [ -f "./animations.sh" ]; then
    source ./animations.sh
else
    echo "Error: animations.sh not found."
    exit 1
fi

BASE_DIR=$(dirname "$(pwd)")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/cleanup_$(date +%Y%m%d_%H%M%S).log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Function to log output
log() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Cleanup cache and temp files
clear
display_ascii_art
spinner "Cleaning cache and temporary files" &
sleep 2

log "=== CLEANUP STARTED - $(date) ==="

# Delete User Cache
log "\nDeleting user cache..."
rm -rf ~/Library/Caches/* && log "User cache cleared." || log "Failed to clear user cache."

# Delete System Cache
log "\nDeleting system cache..."
sudo rm -rf /Library/Caches/* && log "System cache cleared." || log "Failed to clear system cache."

# Delete Temporary Files
log "\nDeleting temporary files..."
sudo rm -rf /private/tmp/* && log "Temporary files cleared." || log "Failed to clear temporary files."

# Delete Application Support Cache
log "\nClearing application support cache..."
rm -rf ~/Library/Application\ Support/*Cache* && log "Application support cache cleared." || log "Failed to clear application support cache."

# Clear Trash
log "\nEmptying Trash..."
rm -rf ~/.Trash/* && log "Trash emptied." || log "Failed to empty trash."

# Optimize Disk Usage
log "\nOptimizing disk usage..."
sudo diskutil repairPermissions / && log "Disk permissions repaired." || log "Failed to repair disk permissions."

log "\n=== CLEANUP COMPLETED - $(date) ==="
kill $!
