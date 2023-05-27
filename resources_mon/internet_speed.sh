#!/bin/bash

datetime=$(date +%Y-%m-%d\ %H:%M:%S)
result=$(speedtest-cli --simple | tr '\n' ' ' )

# echo \[$datetime\] $result >> /home/sergiomancuello/logs/internet_speed.log
echo \[$datetime\] $result