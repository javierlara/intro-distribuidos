#!/bin/sh

interfaces="tap1 tap2 tap3"

#config host 1
IPhost1=157.92.48.127
miIPVirtual1=10.11.24.8
IPVirtualHost1=10.11.24.5
portHost1=26000
#config host 2
IPhost2=157.92.48.127
miIPVirtual2=10.11.23.9
IPVirtualHost2=10.11.23.6
portHost2=27000

#config host 3
IPhost3=157.92.48.41
miIPVirtual3=10.11.25.10
IPVirtualHost3=10.11.25.7
portHost3=28000

for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
done
sudo pkill openvpn

sudo tunctl -t tap1
exec sudo openvpn --port $portHost1 --remote $IPhost1 --dev tap1 --ifconfig $miIPVirtual1 255.255.255.0 $IPVirtualHost1 & 
sudo ifconfig tap1 promisc

sudo tunctl -t tap2
exec sudo openvpn --port $portHost2 --remote $IPhost2 --dev tap2 --ifconfig $miIPVirtual2 255.255.255.0 $IPVirtualHost2 & 
sudo ifconfig tap2 promisc

sudo tunctl -t tap3
exec sudo openvpn --port $portHost3 --remote $IPhost3 --dev tap3 --ifconfig $miIPVirtual3 255.255.255.0 $IPVirtualHost3 & 
sudo ifconfig tap3 promisc
