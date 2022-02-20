# RPiWlanApHost-switcher

1. vytvorit slozku: 
  
  sudo mkdir -p /opt/rebelove.org
  
  cd /opt/rebelove.org 
  
  git clone https://github.com/Rebel3D-CZ/RPiWlanApHost-switcher.git
  
2. Spustit:

	sudo /opt/rebelove.org/sbin/setup_network.sh
  
	sudo rm /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
  
	sudo ln -s /boot/octopi-wpa-supplicant.txt /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
   
opravit v souboru /etc/wpa_supplicant/wpa_supplicant-ap0.conf hodnotu country=CZ

  daji se tam i menit pristupove udaje AP
  host udaje se meni v /boot/octopi-wpa-supplicant.txt ... jako do ted

VOLITELNE 

3. tohle spusti pevny ethernet pod puvodnim jmenem eth0
	
	sudo raspi-config
		 
	volba  6 - Advanced option
	volba A4 - Network Interface Names
	volba    - No
	povolit reboot
	
4. sluzby

	spustit /opt/rebelove.org/sbin/setup_systemd.sh
