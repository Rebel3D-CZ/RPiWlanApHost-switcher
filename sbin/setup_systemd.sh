#!/bin/bash

# install daemon
if [ ! -f /etc/systemd/system/r3d-daemon.service ]
then
  ln -s /opt/rebelove.org/etc/systemd/r3d-daemon.service /etc/systemd/system/r3d-daemon.service

  systemctl daemon-reload
  systemctl start r3d-daemon.service
  systemctl enable r3d-daemon.service
fi

