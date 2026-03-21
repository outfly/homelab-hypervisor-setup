#!/bin/bash

# Script to blacklist Nouveau driver and optionally reboot
# Author: ChatGPT

BLACKLIST_FILE="/etc/modprobe.d/blacklist-nouveau.conf"

echo "=== Blacklisting Nouveau Driver ==="

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo or as root."
    exit 1
fi

# Create or overwrite the blacklist file
echo "Creating blacklist file at $BLACKLIST_FILE..."
cat << EOF > "$BLACKLIST_FILE"
# Disable Nouveau driver
blacklist nouveau
options nouveau modeset=0
# modeset=0 ensures nouveau doesn't initialize the GPU.
EOF

echo "Blacklist created. Nouveau will not initialize GPU on next boot."

# Regenerate initramfs
echo "Updating initramfs..."
update-initramfs -c -k $(uname -r)

echo "Initramfs updated successfully."

# Ask user if they want to reboot
read -p "Do you want to reboot now to apply changes? (Y/n): " REBOOT_ANSWER
REBOOT_ANSWER=${REBOOT_ANSWER:-Y}  # Default to Yes

if [[ "$REBOOT_ANSWER" =~ ^[Yy]$ ]]; then
    echo "Rebooting now..."
    reboot now
else
    echo "Reboot skipped. Please remember to reboot later to apply changes."
fi
