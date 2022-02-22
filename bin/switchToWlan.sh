#!/bin/bash


# check if running as root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi

if systemctl is-active --quiet wpa_supplicant@wlan0;
then
  systemctl restart wpa_supplicant@wlan0
else
  systemctl start wpa_supplicant@wlan0
fi
exit 0
