#!/bin/sh

interfaces="tap7"

BASEDIR=$(dirname $0)
serverIp=`cat ${BASEDIR}/../serverIp.conf`
size=${#serverIp} 

echo "conectado a server $serverIp"
if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
	echo "bien"
else
	echo "La IP del Host esta mal."
	exit 1
fi

miIPVirtualC=10.43.9.65
miIPVirtualDestinoC=10.43.9.64
maskC=255.255.255.240
miPortC=32000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortC --dev $interfaces --ifconfig $miIPVirtualC $maskC $miIPVirtualDestinoC