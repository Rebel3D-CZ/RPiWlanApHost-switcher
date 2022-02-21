# RPi Wlan Ap/Host switcher

**1. Vytvorit slozku:**
```
cd
git clone https://github.com/Rebel3D-CZ/RPiWlanApHost-switcher.git
sudo mkdir -p /opt/rebelove.org
sudo cp -r /home/pi/RPiWlanApHost-switcher/* /opt/rebelove.org/
```

**2. Spustit:**
```
sudo /opt/rebelove.org/sbin/setup_network.sh
sudo rm /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo ln -s /boot/octopi-wpa-supplicant.txt /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
```   
opravit v souboru /etc/wpa_supplicant/wpa_supplicant-ap0.conf hodnotu country=CZ

  daji se tam i menit pristupove udaje AP
  host udaje se meni v /boot/octopi-wpa-supplicant.txt ... jako do ted

**3. VOLITELNE (pouze při použití eth0, u Pi Zero W 2 neni potreba):**

Pokud chcete nastavit dratovy ethernet, tak:
tohle spusti zarizeni pod puvodnim jmenem eth0

```
sudo raspi-config
```

volba  6 - Advanced option
volba A4 - Network Interface Names
volba    - No
povolit reboot

a tohle zajisti konfiguraci DHCP:

```
cat | sudo tee /etc/systemd/network/20-wired.network <<DATA
[Match]
Name=eth0

[Network]
DHCP=yes
DATA
```

**4. Sluzby**

spustit 
```
sudo /opt/rebelove.org/sbin/setup_systemd.sh
```
