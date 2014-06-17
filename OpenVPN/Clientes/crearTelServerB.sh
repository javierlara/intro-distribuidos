#!/bin/sh
if [ "$(id -u)" != "0" ]; then
	echo "Debe ejecutar como administrador"
	exit 1
fi

if ! type "tunctl" > /dev/null; then
	echo "se tiene que instalar la función tunctl"
	exit 1
fi
if ! type "openvpn" > /dev/null; then
	echo "se tiene que instalar la función openvpn"
	exit 1
fi
BASEDIR=$(dirname $0)
serverConfig="${BASEDIR}/../serverIp.conf"
if [ ! -f "$serverConfig" ]; then
    echo "El archivo $serverConfig no existe, copiar el $serverConfig.sample a $serverConfig y poner la IP fisica del modelo"
    exit 1
fi

# limipo los taps
echo "Limipiando taps"
#${BASEDIR}/../borrarInterfaces.sh

echo "Iniciando telServer B"
interfaces="tap7"

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

miIPVirtualC=10.94.6.129
miIPVirtualDestinoC=10.94.6.139
maskC=255.255.255.192
miPortC=32000

sudo openvpn --rmtun --dev $interfaces


sudo ifconfig $interfaces promisc
echo "nameserver 10.94.6.130" > /etc/resolv.conf
sudo  openvpn --remote $serverIp --port $miPortC --dev $interfaces --ifconfig $miIPVirtualC $maskC $miIPVirtualDestinoC &
sleep 5


IF1="tap7" #name of the first interface
IF2="tap10" #name of the second interface
IP1="10.94.6.129" #IP address associated with $IF1
IP2="10.94.5.130" #IP address associated with $IF2
P1="10.94.6.170" #IP address of the gateway at Provider 1
P2="10.94.5.134" #IP address of the gateway at provider 2
B_NET="10.94.6.128/26" #IP network $P1 is in
S_NET="10.94.5.128/28" #the IP network $P2 is in
chmod 666 /etc/iproute2/rt_tables
echo 2 tablab >> /etc/iproute2/rt_tables
echo 3 tablas >> /etc/iproute2/rt_tables

subredes="183.44.3.0/29 10.94.6.128/25 10.94.5.128/25 10.15.65.0/24 205.129.31.0/26 205.129.31.128/25 10.43.9.0/24 15.55.200.32/30 15.55.200.36/30 15.55.200.40/30 205.129.31.64/30"
for subred in $subredes; do
    #sudo route add -net $subred gw 10.94.6.170 $interfaces
    ip route add $subred via $P1 tab 2
    ip route add $subred via $P2 tab 3
done
ip route add $B_NET dev $IF1 src $IP1 tab 2

# Se agregan reglas por defecto
ip rule add table main prio 32766
ip rule add table default prio 32767

# Se agregan las reglas del telnet
ip rule add from $IP1 lookup tablab prio 1001
ip rule add to $IP1 lookup tablab prio 1002
ip rule add from $IP2 lookup tablas prio 1003
ip rule add to $IP2 lookup tablas prio 1004

ip rule add table tablab prio 1101
ip rule add table tablas prio 1102