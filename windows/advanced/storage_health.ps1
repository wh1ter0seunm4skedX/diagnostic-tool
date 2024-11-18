# Check disk health
Get-PhysicalDisk | Select-Object DeviceID, MediaType, HealthStatus

# Check SMART data (requires SMART-capable hardware)
wmic diskdrive get status
