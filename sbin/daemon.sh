#!/bin/bash
APPROOT=/opt/rebelove.org
WDSTART=0
WDTIMEOUT=20

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
          $APPROOT/bin/switchToAP.sh
          sleep 1m
        fi
      fi
    fi
  fi

  # do some commands
  if [ -f $APPROOT/var/switch-to-ap.lock ]
  then
    $APPROOT/bin/switchToAP.sh
    rm $APPROOT/var/switch-to-ap.lock
    sleep 1m
  fi
  if [ -f $APPROOT/var/switch-to-wlan.lock ]
  then
    $APPROOT/bin/switchToWlan.sh
    rm $APPROOT/var/switch-to-wlan.lock
    sleep 1m
  fi
  sleep 10s
done
