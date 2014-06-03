#!/bin/sh
interfaces="tap1 tap2 tap3"
IPhost=`cat hosts.conf`
size=${#IPhost} 

echo "$IPhost el count es  $size"
if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
	echo "bien"
else
	echo "La IP del Host esta mal."
	exit 1
fi
#config host 1 sub red D
IPhost1=$IPhost
miIPVirtual1=10.94.6.131
IPVirtualHost1=10.94.6.130
mask1=255.255.255.192
portHost1=26000

#config host 2 sub red J
IPhost2=$IPhost
miIPVirtual2=10.43.9.20
IPVirtualHost2=10.43.9.21
mask2=255.255.255.224
portHost2=27000

#config host 3 sub red P
IPhost3=$IPhost
miIPVirtual3=10.15.65.228
IPVirtualHost3=10.15.65.227
mask3=255.255.255.224
portHost3=28000

for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
done
sudo pkill openvpn

sudo tunctl -t tap1
exec sudo openvpn --port $portHost1 --remote $IPhost1 --dev tap1 --ifconfig $miIPVirtual1 $mask1 $IPVirtualHost1 & 
sudo ifconfig tap1 promisc

sudo tunctl -t tap2
exec sudo openvpn --port $portHost2 --remote $IPhost2 --dev tap2 --ifconfig $miIPVirtual2 $mask2 $IPVirtualHost2 & 
sudo ifconfig tap2 promisc

sudo tunctl -t tap3
exec sudo openvpn --port $portHost3 --remote $IPhost3 --dev tap3 --ifconfig $miIPVirtual3 $mask3 $IPVirtualHost3 & 
sudo ifconfig tap3 promisc
