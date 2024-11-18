echo "Firewall Status:"
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

echo "Security Updates:"
softwareupdate --list
