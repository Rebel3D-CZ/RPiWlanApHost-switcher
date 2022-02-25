#!/bin/bash

cd /home/pi/RPiWlanApHost-switcher
git pull https://github.com/Rebel3D-CZ/RPiWlanApHost-switcher.git

sudo cp -r -u /home/pi/RPiWlanApHost-switcher/* /opt/rebelove.org/
sudo systemctl daemon-reload
sudo systemctl restart r3d-daemon.service
