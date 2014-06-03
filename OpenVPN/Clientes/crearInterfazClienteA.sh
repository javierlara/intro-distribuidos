#!/bin/sh

interfaces="tap1"

serverIpA=`cat ../serverIP.conf`
size=${#serverIpA} 

echo "$serverIpA el count es  $size"
if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
	echo "bien"
else
	echo "La IP del Host esta mal."
	exit 1
fi

miIPVirtualA=10.94.6.130
miIPVirtualDestinoA=10.94.6.131
maskA=255.255.255.192
miPortA=26000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIpA --port $miPortA --dev $interfaces --ifconfig $miIPVirtualA $maskA $miIPVirtualDestinoA 