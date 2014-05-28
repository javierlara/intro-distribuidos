#!/bin/sh
interfaces="tap4"
serverIp=157.92.51.231
miIPVirtual=10.11.23.6
miIPVirtualDestino=10.11.23.9
miPort=27000
for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
done

sudo pkill openvpn
sleep 5

sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPort --dev $interfaces --ifconfig $miIPVirtual 255.255.255.0 $miIPVirtualDestino