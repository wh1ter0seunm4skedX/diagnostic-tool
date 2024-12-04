#!/bin/zsh

if [ -f "./animations.sh" ]; then
    source ./animations.sh
else
    echo "Error: animations.sh not found."
    exit 1
fi

BASE_DIR=$(dirname "$(pwd)")
LOG_DIR="$BASE_DIR/shared/logs"
LOG_FILE="$LOG_DIR/cleanup_$(date +%Y%m%d_%H%M%S).log"

mkdir -p "$LOG_DIR"

log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

clear
display_ascii_art
spinner "Preparing Cleanup Tool" &
sleep 2
kill $! 2>/dev/null

log "\033[34m=== CLEANUP STARTED - $(date) ===\033[0m"

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    log "\033[33mDry run mode enabled. No files will be deleted.\033[0m"
fi

cleanup_task() {
    local description=$1
    local command=$2
    log "\n$description..."
    if $DRY_RUN; then
        log "\033[36mSimulating: $command\033[0m"
    else
        eval "$command" && log "\033[32mSuccess: $description.\033[0m" || log "\033[31mFailed: $description.\033[0m"
    fi
}

cleanup_task "Deleting user cache" "rm -rf ~/Library/Caches/*"
cleanup_task "Deleting system cache" "sudo rm -rf /Library/Caches/*"
cleanup_task "Deleting temporary files" "sudo rm -rf /private/tmp/*"
cleanup_task "Clearing application support cache" "rm -rf ~/Library/Application\\ Support/*Cache*"
cleanup_task "Emptying Trash" "rm -rf ~/.Trash/*"
cleanup_task "Optimizing disk usage" "sudo diskutil repairPermissions /"

log "\033[34m=== CLEANUP COMPLETED - $(date) ===\033[0m"

spinner "Finalizing cleanup" &
sleep 2
kill $! 2>/dev/null

echo -e "\033[0;32mCleanup complete! Logs saved to $LOG_FILE.\033[0m"
