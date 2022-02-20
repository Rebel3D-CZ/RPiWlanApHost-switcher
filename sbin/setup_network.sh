#/bin/bash

# set hostname
/opt/rebelove.org/sbin/set_hostname.sh

# setup wifi profiles
HNAME=`hostname`
/opt/rebelove.org/sbin/setup_wlan_and_AP_modes.sh -s stationSSID -p 'rebelove.org' -a $HNAME -r 'rebelove.org'
