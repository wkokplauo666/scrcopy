#!/bin/bash

devices=$(adb devices)

#argument check

if [ $# -eq 1 ]; then
	for arg in "$@"; do
		if [ "$arg" = "-h" ]; then
			echo "scrcopy 0.0.1	- Android automatic screen copy. 	<narada.fox7pc@gmail.com>
Usage: scrcopy [options]

		-h		Print this help information and exit


How to fix problems that you may see:
	device not found. 	:	Connect an USB-A to USB-C adapter to your target android phone and your computer 	
	device unauthorized. 	:	Go to your target phone then open settings > Developer option > USB Debugging (enable it) 
	invalid ip address	:	verify your target's ip address using such program like nmap, arping and so
	dev option not showing	:	Go to About phone > Software info > click Version number until you get dev option"
			exit 0
	
		fi
	done
fi

if echo "${devices}" | grep -q R
then
	if adb devices | grep -q unauth
	then
		echo "device unauthorized."
		exit
	else
		echo "device authorized!"
	fi
	echo "device found!"
else
	echo "device not found. (use -h to see help)"
	exit
fi
adb tcpip 9999
echo 'remove the device'
sleep 8
echo 'enter device ip adress:'
read ip_addr
conn_mesg=$(adb connect $ip_addr:9999)
if echo "${conn_mesg}" | grep -q connected
then
	echo "valid ip adress..."
else
	echo "invalid ip adress"
	exit
fi
scrcpy
adb disconnect
clear
exit
