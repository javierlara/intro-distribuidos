#!/bin/sh

interfaces="tap1"

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

miIPVirtualA=10.94.5.194
miIPVirtualDestinoA=10.94.5.195
maskA=255.255.255.192
miPortA=26000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortA --dev $interfaces --ifconfig $miIPVirtualA $maskA $miIPVirtualDestinoA 