#!/bin/sh

interfaces="tap2"
serverIp=192.168.0.46
miIPVirtualB=10.15.65.198
miIPVirtualDestinoB=10.15.65.199
maskB=255.255.255.224
miPortB=27000


sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIp --port $miPortB --dev $interfaces --ifconfig $miIPVirtualB $maskB $miIPVirtualDestinoB