#!/bin/sh

interfaces="tap2"

serverIp=`cat ../serverIP.conf`
size=${#serverIp} 

echo "$serverIp el count es  $size"
if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
	echo "bien"
else
	echo "La IP del Host esta mal."
	exit 1
fi

miIPVirtualB=10.15.65.198
miIPVirtualDestinoB=10.15.65.199
maskB=255.255.255.224
miPortB=27000


sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortB --dev $interfaces --ifconfig $miIPVirtualB $maskB $miIPVirtualDestinoB