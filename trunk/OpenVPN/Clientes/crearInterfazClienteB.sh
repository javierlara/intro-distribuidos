#!/bin/sh

interfaces="tap2"

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

miIPVirtualB=10.94.5.149
miIPVirtualDestinoB=10.94.5.148
maskB=255.255.255.224
miPortB=27000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortB --dev $interfaces --ifconfig $miIPVirtualB $maskB $miIPVirtualDestinoB