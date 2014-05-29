#!/bin/sh

interfaces="tap1"
serverIpA=192.168.0.46
miIPVirtualA=10.94.6.130
miIPVirtualDestinoA=10.94.6.131
maskA=255.255.255.192
miPortA=26000

sudo openvpn --rmtun --dev $interfaces


sudo tunctl -t $interfaces
sudo ifconfig $interfaces promisc
sudo  openvpn --remote $serverIpA --port $miPortA --dev $interfaces --ifconfig $miIPVirtualA $maskA $miIPVirtualDestinoA 