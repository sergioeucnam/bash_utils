#!/bin/bash

cpu_usage=$(top -b -n 1 | grep "Cpu(s)")
cpu_usage=$(echo $cpu_usage | awk '{print $2 + $4}')
# pwd=$(pwd)

if [ $(echo "$cpu_usage > 85" | bc) -eq 1 ]; then
    echo "<txt><span weight='Bold' fgcolor='Red'>CPU $cpu_usage %</span></txt>"
  
  elif [ $(echo "$cpu_usage > 70" | bc) -eq 1 ]; then
    echo "<txt><span weight='Bold' fgcolor='Orange'>CPU $cpu_usage %</span></txt>"
  
  elif [ $(echo "$cpu_usage > 50" | bc) -eq 1 ]; then
    echo "<txt><span weight='Bold' fgcolor='Yellow'>CPU $cpu_usage %</span></txt>"
else
echo "<txt><span weight='Bold' fgcolor='lightgreen'>CPU $cpu_usage %</span></txt>"
fi
