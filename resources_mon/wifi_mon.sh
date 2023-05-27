#!/bin/bash
# This script will monitor the wifi connection and output the wifi name and signal strength to stout
# This script is intended to be run in a loop and output to a stdout monitor

interface_name="wlp59s0"
wifi_name=$(iwgetid -r)
wifi_signal=$(iwconfig $interface_name | grep -o -E 'Quality=[0-9]+/[0-9]+' | cut -d= -f2 | cut -d/ -f1)
#Show the internet speed in tooltip from a file 

#Print the wifi name and signal strength


if [ -z "$wifi_name" ]; then
    echo "<txt><span weight='Bold' fgcolor='Red'>Wifi Down</span></txt>"
    exit 0
fi



if [ $wifi_signal -gt 85 ]; then
    echo "<txt><span weight='Bold' fgcolor='green'>$wifi_name  $wifi_signal%</span></txt>"
elif [ $wifi_signal -gt 60 ]; then
    echo "<txt><span weight='Bold' fgcolor='lightgreen'>$wifi_name  $wifi_signal%</span></txt>"
elif [ $wifi_signal -gt 30 ]; then
    echo "<txt><span weight='Bold' fgcolor='orange'>$wifi_name  $wifi_signal%</span></txt>"
else
    echo "<txt><span weight='Bold' fgcolor='red'>$wifi_name  $wifi_signal%</span></txt>"
fi

