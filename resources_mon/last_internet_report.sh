#!/bin/bash

#This script will display the last internet report from a file
#The file is in /home/sergiomancuello/Desktop/internet_speed.log
#Take today date then grep the file for that date, and return only the last line

#Get today date
today=$(date +%Y-%m-%d)

#Get the last line of the file
last_line=$(grep $today /home/sergiomancuello/Desktop/internet_speed.log | tail -1)

#Print the last line
echo "<txt><span weight='Bold' fgcolor='green'>$last_line%</span></txt>"
