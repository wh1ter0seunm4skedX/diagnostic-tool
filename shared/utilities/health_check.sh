echo "Performing basic health check..."

# Disk space check
DISK_SPACE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $DISK_SPACE -gt 90 ]; then
    echo "Warning: Disk space usage is above 90%!"
else
    echo "Disk space usage is under control."
fi

# Memory usage check
MEMORY_USAGE=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
echo "Active memory pages: $MEMORY_USAGE"
