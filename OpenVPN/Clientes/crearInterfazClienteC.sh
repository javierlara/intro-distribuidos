#!/bin/sh

interfaces="tap3"
serverIp=192.168.0.46
miIPVirtualC=10.15.65.227
miIPVirtualDestinoC=10.15.65.228
maskC=255.255.255.224
miPortC=28000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortC --dev $interfaces --ifconfig $miIPVirtualC $maskC $miIPVirtualDestinoC