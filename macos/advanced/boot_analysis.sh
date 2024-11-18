echo "WARNING: This script will restart your computer to measure boot time."
read -p "Do you want to proceed? (yes/no): " response
if [[ ! "$response" =~ ^(yes|y)$ ]]; then
    echo "Action canceled."
    exit 1
fi

# Proceed with boot analysis
sudo shutdown -r now
