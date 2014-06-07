#!/bin/sh

interfaces="tap4"

BASEDIR=$(dirname $0)
serverIp=`cat ${BASEDIR}/../serverIp.conf`
size=${#serverIp} 

echo "conectado a server $serverIp"
if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
	echo "bien"
else
	echo "La IP del DNS esta mal."
	exit 1
fi

miIPVirtual=10.94.5.161
miIPVirtualDestino=10.43.9.46
mask=255.255.255.240
miPort=29000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPort --dev $interfaces --ifconfig $miIPVirtual $mask $miIPVirtualDestino 