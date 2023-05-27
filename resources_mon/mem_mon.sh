#!/bin/bash

ram=$(free -h | awk '/Mem/{print $3 " / " $2}')
ram_percentage=$(free -h | awk '/Mem/{print $3 "/" $2}' | awk -F'/' '{print $1/$2*100}')
ram_percentage=$(printf "%.0f" $ram_percentage)


if [ $ram_percentage -gt 85 ]; then
    echo "<txt><span weight='Bold' fgcolor='Red'>RAM $ram  $ram_percentage%</span></txt>"
    # echo "<txt><span weight='Bold' fgcolor='Red'>$ram_percentage %</span></txt>"
elif [ $ram_percentage -gt 70 ]; then
    echo "<txt><span weight='Bold' fgcolor='Orange'>RAM $ram  $ram_percentage%</span></txt>"
    # echo "<txt><span weight='Bold' fgcolor='Orange'>$ram_percentage %</span></txt>"
elif [ $ram_percentage -gt 50 ]; then
    echo "<txt><span weight='Bold' fgcolor='Yellow'>RAM $ram  $ram_percentage%</span></txt>"
    # echo "<txt><span weight='Bold' fgcolor='Yellow'>$ram_percentage %</span></txt>"
else
    echo "<txt><span weight='Bold' fgcolor='lightgreen'>RAM $ram  $ram_percentage%</span></txt>"
    # echo "<txt><span weight='Bold' fgcolor='green'>$ram_percentage %</span></txt>"
fi
