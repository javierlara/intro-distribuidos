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
sudo  openvpn --remote $serverIp --port $miPortA --dev $interfaces --ifconfig $miIPVirtualA $maskA $miIPVirtualDestinoA &
sleep 3

subredes="10.94.6.128/25 10.94.5.128/25 10.15.65.0/24 205.129.31.0/26 205.129.31.128/25"

 for subred in $subredes; do
     sudo route add -net $subred gw 10.94.5.244 $interfaces
 done
