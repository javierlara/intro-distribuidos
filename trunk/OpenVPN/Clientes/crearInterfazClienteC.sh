#!/bin/sh

interfaces="tap3"

serverIp=`cat ../serverIP.conf`
size=${#serverIp} 

echo "$serverIp el count es  $size"
if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
	echo "bien"
else
	echo "La IP del Host esta mal."
	exit 1
fi

serverIp=192.168.0.46
miIPVirtualC=10.15.65.227
miIPVirtualDestinoC=10.15.65.228
maskC=255.255.255.224
miPortC=28000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortC --dev $interfaces --ifconfig $miIPVirtualC $maskC $miIPVirtualDestinoC