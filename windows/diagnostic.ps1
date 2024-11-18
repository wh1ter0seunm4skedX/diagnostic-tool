<#
.SYNOPSIS
    Comprehensive diagnostic tool for Windows systems.

.DESCRIPTION
    This script performs a variety of system checks to identify potential issues
    affecting system performance, hardware, and network health. Results are saved
    to a log file for review.

.NOTES
    Run this script with elevated privileges (as Administrator).
    Logs are saved in ../shared/logs/diagnostic_windows_<timestamp>.log
#>

# Output file
$LogFile = "../shared/logs/diagnostic_windows_$(Get-Date -Format yyyyMMdd_HHmmss).log"

# Function to log output
function Log {
    param (
        [string]$Message,
        [switch]$ToConsole   # Optional switch for console output
    )
    if ($ToConsole) {
        Write-Host $Message
    }
    $Message | Out-File -FilePath $LogFile -Append
}

# Start diagnostics
Log "Starting Windows Diagnostics - $(Get-Date)" -ToConsole
Log "==========================================`n" -ToConsole

# System Information
Log "=== SYSTEM INFORMATION ===" -ToConsole
try {
    $SystemInfo = systeminfo
    Log $SystemInfo -ToConsole
} catch {
    Log "Failed to retrieve system information: $_" -ToConsole
}

# CPU and Memory Usage
Log "`n=== CPU AND MEMORY USAGE ===" -ToConsole
try {
    $CPU = Get-Counter '\Processor(_Total)\% Processor Time'
    $Memory = Get-WmiObject Win32_OperatingSystem | Select-Object FreePhysicalMemory, TotalVisibleMemorySize
    Log "CPU Usage: $($CPU.CounterSamples[0].CookedValue)%" -ToConsole
    Log "Memory: $($Memory.FreePhysicalMemory) KB free of $($Memory.TotalVisibleMemorySize) KB total" -ToConsole
} catch {
    Log "Failed to retrieve CPU and memory information: $_" -ToConsole
}

# Disk Space
Log "`n=== DISK SPACE ===" -ToConsole
try {
    $DiskInfo = Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="UsedGB"; Expression={[math]::round($_.Used / 1GB, 2)}}, @{Name="FreeGB"; Expression={[math]::round($_.Free / 1GB, 2)}}, @{Name="TotalGB"; Expression={[math]::round($_.Used / 1GB + $_.Free / 1GB, 2)}}
    foreach ($Disk in $DiskInfo) {
        Log "Drive $($Disk.Name): $($Disk.UsedGB) GB used, $($Disk.FreeGB) GB free, $($Disk.TotalGB) GB total" -ToConsole
    }
} catch {
    Log "Failed to retrieve disk space information: $_" -ToConsole
}

# Installed Applications
Log "`n=== INSTALLED APPLICATIONS ===" -ToConsole
try {
    $InstalledApps = Get-WmiObject Win32_Product | Select-Object Name, Version
    foreach ($App in $InstalledApps) {
        Log "$($App.Name) - Version $($App.Version)"
    }
} catch {
    Log "Failed to retrieve installed applications: $_" -ToConsole
}

# Startup Programs
Log "`n=== STARTUP PROGRAMS ===" -ToConsole
try {
    $StartupItems = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
    foreach ($Item in $StartupItems.PSObject.Properties) {
        Log "$($Item.Name) - $($Item.Value)"
    }
} catch {
    Log "Failed to retrieve startup programs: $_" -ToConsole
}

# Network Diagnostics
Log "`n=== NETWORK DIAGNOSTICS ===" -ToConsole
try {
    Log "Ping test to Google:" -ToConsole
    $PingResult = Test-Connection -ComputerName google.com -Count 4
    foreach ($Result in $PingResult) {
        Log "$($Result.Address) - Time: $($Result.ResponseTime)ms" -ToConsole
    }
} catch {
    Log "Failed to perform ping test: $_" -ToConsole
}

try {
    Log "Active network connections:" -ToConsole
    $NetConnections = Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
    foreach ($Connection in $NetConnections) {
        Log "$($Connection.LocalAddress):$($Connection.LocalPort) -> $($Connection.RemoteAddress):$($Connection.RemotePort) ($($Connection.State))" -ToConsole
    }
} catch {
    Log "Failed to retrieve network connections: $_" -ToConsole
}

# Windows Updates
Log "`n=== WINDOWS UPDATES ===" -ToConsole
try {
    $WindowsUpdates = Get-WindowsUpdateLog
    Log $WindowsUpdates
} catch {
    Log "Failed to retrieve Windows updates: $_" -ToConsole
}

# Error Logs
Log "`n=== ERROR LOGS ===" -ToConsole
try {
    $SystemErrors = Get-WinEvent -LogName System -MaxEvents 10 | Where-Object {$_.LevelDisplayName -eq "Error"}
    foreach ($Error in $SystemErrors) {
        Log "$($Error.TimeCreated) - $($Error.Message)" -ToConsole
    }
} catch {
    Log "Failed to retrieve error logs: $_" -ToConsole
}

# Hardware Information
Log "`n=== HARDWARE INFORMATION ===" -ToConsole
try {
    $HardwareInfo = Get-WmiObject Win32_ComputerSystem
    Log "Manufacturer: $($HardwareInfo.Manufacturer)" -ToConsole
    Log "Model: $($HardwareInfo.Model)" -ToConsole
    Log "Total Physical Memory: $($HardwareInfo.TotalPhysicalMemory)" -ToConsole
} catch {
    Log "Failed to retrieve hardware information: $_" -ToConsole
}

# End diagnostics
Log "`nDiagnostics completed. Logs saved to $LogFile" -ToConsole
