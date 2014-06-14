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
${BASEDIR}/../borrarInterfaces.sh

echo "Iniciando cliente B"

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


sudo ifconfig $interfaces promisc
echo "nameserver 10.94.5.161" > /etc/resolv.conf
sudo  openvpn --remote $serverIp --port $miPortC --dev $interfaces --ifconfig $miIPVirtualC $maskC $miIPVirtualDestinoC &

sleep 3

subredes="10.94.6.128/25 10.94.5.128/25 10.15.65.0/24 205.129.31.0/26 205.129.31.128/25 10.43.9.0/24 15.55.200.32/30 15.55.200.36/30 15.55.200.40/30 205.129.31.64/30"
 for subred in $subredes; do
     sudo route add -net $subred gw 10.15.65.114 $interfaces
 done
