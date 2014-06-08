#!/bin/sh

interfaces="tap3"

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

miIPVirtualC=10.15.65.101
miIPVirtualDestinoC=10.15.65.100
maskC=255.255.255.224
miPortC=28000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortC --dev $interfaces --ifconfig $miIPVirtualC $maskC $miIPVirtualDestinoC &

sleep 3

subredes="10.15.65.0/27 10.94.6.128/26 10.94.65.128/25 10.94.5.192/26 10.43.9.0/24 205.129.31.128/30 10.15.65.32/27 10.94.5.144/28 205.129.31.132/30 10.15.65.64/27 10.94.5.160/28 10.94.5.176/28 205.129.31.0/26 10.94.6.192/26 10.94.5.128/28 205.129.31.64/30"
for subred in $subredes; do
    sudo route add -net $subred gw 10.15.65.114 $interfaces
done
