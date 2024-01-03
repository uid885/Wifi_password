#!/bin/bash
# Author:           Christo Deale                  
# Date  :           2024-01-03           
# Wifi_password:    Utility to retrieve WiFi password from system

# Check if WiFi device is on, if not, enable and start it
wifi_device=$(nmcli device | grep -E 'wifi.*connected' | awk '{print $1}')

if [ -z "$wifi_device" ]; then
    echo "Enabling and starting WiFi..."
    nmcli r wifi on
fi

# Header for the WiFi network list
printf "%-20s %-10s %-10s %-15s\n" "SSID" "SIGNAL" "BARS" "SECURITY"
echo "------------------------------------------------------"

# List available WiFi networks and show SSID, SIGNAL, BARS, and SECURITY
nmcli device wifi list | awk 'NR>1 {printf "%-20s %-10s %-10s %-15s\n", $2, $7, $8, $9}'

# Ask for WiFi device identification
read -p "Identify your WiFi device: " WiFi

# Get WiFi password
password=$(nmcli -s -g 802-11-wireless-security.psk connection show "$WiFi")

# Output password in red
echo -e "\033[31mYour password is: $password\033[0m"
