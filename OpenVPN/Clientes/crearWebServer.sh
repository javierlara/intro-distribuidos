#!/bin/sh

interfaces="tap8"

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

miIPVirtualWebServer=10.15.65.136
miIPVirtualDestinoWebServer=10.15.65.135
maskWebbServer=255.255.255.192
miPortWebServer=33000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortWebServer --dev $interfaces --ifconfig $miIPVirtualWebServer $maskWebbServer $miIPVirtualDestinoWebServer