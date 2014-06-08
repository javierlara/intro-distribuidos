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

miIPVirtualWebServer=205.129.31.11
miIPVirtualDestinoWebServer=205.129.31.10
maskWebbServer=255.255.255.192
miPortWebServer=33000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortWebServer --dev $interfaces --ifconfig $miIPVirtualWebServer $maskWebbServer $miIPVirtualDestinoWebServer &
sleep 3

subredes="10.94.6.128/25 10.94.5.128/25 10.15.65.0/24 205.129.31.0/26 205.129.31.128/25"

for subred in $subredes; do
    sudo route add -net $subred gw 205.129.31.52 $interfaces
done