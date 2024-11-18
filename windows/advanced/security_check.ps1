# Check Firewall status
Get-NetFirewallProfile | Select-Object Name, Enabled

# Check Windows Defender status
Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled

# Check recent updates
Get-HotFix | Select-Object Description, InstalledOn
