#!/bin/bash
APPROOT=/opt/rebelove.org
WDSTART=0
WDTIMEOUT=20
WPASETUP=/etc/wpa_supplicant/wpa_supplicant-wlan0.conf
SSIDSCANDELAY=60
SSIDSCANSTART=0
LOOPDELAY=10s

while [ 1 ]
do
  # watch Wifi
  if iwconfig ap0 > /dev/null 2>&1
  then
    # in AP, reset watchdog
    WDSTART=0
  else
    # in wlan
    # check if associated
    if iwgetid > /dev/null 2>&1
    then
      # associated, reset watchdog
      WDSTART=`date +%s`
    else
      # not associated
      if [ $WDSTART -eq 0 ]
      then
        # start watchdog
        WDSTART=`date +%s`
      else
        # check watchdog
        TIMEOFFLINE=`expr $(date +%s) - $WDSTART`
        if [ $TIMEOFFLINE -ge $WDTIMEOUT ]
        then
          echo "WLAN down, switching to AP"
          $APPROOT/bin/switchToAP.sh
          sleep 1m
        fi
      fi
    fi
  fi

  # scan available SSIDs
  SINCESCAN=`expr $(date +%s) - $SSIDSCANSTART`
  if [ $SINCESCAN -ge $SSIDSCANDELAY ]
  then
    SSIDSCANSTART=`date +%s`
    iwlist wlan0 scan | grep SSID | cut -f 2 -d '"' > $APPROOT/var/list.ssid
  fi

  # do some commands
  if [ -f $APPROOT/var/switch-to-ap.lock ]
  then
    echo "Switching to AP"
    $APPROOT/bin/switchToAP.sh
    rm $APPROOT/var/switch-to-ap.lock
    sleep 1m
  fi
  if [ -f $APPROOT/var/switch-to-wlan.lock ]
  then
    echo "Switching to WLAN"
    $APPROOT/bin/switchToWlan.sh
    rm $APPROOT/var/switch-to-wlan.lock
    sleep 1m
  fi
  if [ -f $APPROOT/var/updatewifi.lock ]
  then
    echo "Updating WLAN setup"
    SSID=`grep 'ssid=' $APPROOT/var/updatewifi.lock`
    PSK=`grep 'psk=' $APPROOT/var/updatewifi.lock`

    sed --follow-symlinks -i 's/.*ssid=.*/'"$SSID"'/' $WPASETUP
    sed --follow-symlinks -i 's/.*psk=.*/'"$PSK"'/' $WPASETUP
    $APPROOT/bin/switchToWlan.sh
    rm $APPROOT/var/updatewifi.lock
    sleep 1m
  fi
  if [ -f $APPROOT/var/vpn.enable ]
  then
    echo "Enabling VPN"
    $APPROOT/bin/enableVPN.sh
    rm $APPROOT/var/vpn.enable
    sleep 1m
  fi
  if [ -f $APPROOT/var/vpn.disable ]
  then
    echo "Disabling VPN"
    $APPROOT/bin/disableVPN.sh
    rm $APPROOT/var/vpn.disable
    sleep 1m
  fi
  sleep $LOOPDELAY
done
