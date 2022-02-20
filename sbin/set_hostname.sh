#!/bin/bash

# get new hostname
HNAME=`
echo -n "RR400M-"
cat /sys/class/net/wlan0/address | tr -d ':' | cut -c 9- | tr '[a-f]' '[A-F]'
`
# update /etc/hostname
echo $HNAME > /etc/hostname

# set hostname
hostname $HNAME

# update /etc/hosts
sed -i -e 's/^127.0.1.1\t.*$/127.0.1.1\t'$HNAME'/g' /etc/hosts
