Switcher slouží k zpřístupnění Raspberry Pi po WiFi, bez nutnosti připojení seriové konzole či metalické LAN. Funguje to tak, že pokud není Raspbery po doby cca 20s připojené k žádnému přístupovému bodu, přepne se přepne bez rebootu do režimu AP s SSID RR400M-xxx, heslem rebelove.org a dá se k němu tedy připojit jako k AP. Vašemu PC či telefonu přidělí IP z rozsahu 192.168.4.0/24 a adresa Pi je pak 192.168.4.1 a dá se k němu připojit pomocí SSH či jiné služby která na něm poběží.
Primárně tento switcher vznikl pro náš plugin pro ovládání Wifi a VPN z OctoPrintu https://github.com/Rebel3D-CZ/OctoPrint-RR400M-Customizer

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
v souboru /etc/wpa_supplicant/wpa_supplicant-ap0.conf se daji menit pristupove udaje AP

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
