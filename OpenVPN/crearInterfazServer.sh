#!/bin/sh

chequeoArchivo(){
	fileName=${1}
	if [ ! -f "$fileName" ]; then
	    echo "El archivo $fileName no existe, copiar el $fileName.sample a $fileName y poner la IP Fisica de los Hosts"
	    exit 1
	fi
}

chequeoPrograma(){
	nombrePrograma=${1}
	if ! type "$nombrePrograma" > /dev/null; then
		echo "Se tiene que instalar la función $nombrePrograma"
		exit 1
	fi
}

chequeoIPValida(){
	IPDada=${1}
	size=${#IPDada} 

	if [ "$size" -lt 16 ] && [ "$size" -ge 7 ]; then
		echo "$IPDada"
	else
		echo "La IP de ${2} esta mal. IP dada : '$IPDada'"
		exit 1
	fi
}

# Verificación de permisos y programas instalados.
if [ "$(id -u)" != "0" ]; then
	echo "Debe ejecutar como administrador"
	exit 1
fi

chequeoPrograma "tunctl"
chequeoPrograma "openvpn"

#carga de configs

#toma la ip fisica para los Hosts
hostConfig="hosts.conf"
chequeoArchivo $hostConfig

IPhost=`cat $hostConfig`
chequeoIPValida $IPhost "host"

#toma la ip fisica para los DNSs
dnsConfig="dns.conf"
chequeoArchivo $dnsConfig

IPDNS1=`sed -n '1p' $dnsConfig`;
IPDNS2=`sed -n '2p' $dnsConfig`;
IPDNSRoot=`sed -n '3p' $dnsConfig`;

chequeoIPValida $IPDNS1 "DNS 1"
chequeoIPValida $IPDNS2 "DNS 2"
chequeoIPValida $IPDNSRoot "DNS root"

#toma la ip fisica para los servidores FTP TelNet y webServer
serversConfig="servers.conf"
servers=`cat $serversConfig`
chequeoIPValida $servers "los servers FTP telNet y webServer"

#limpio las configs
./borrarInterfaces.sh

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

#config dns 1
IPFisicaDNS1=$IPDNS1
miIPVirtualDNS1=10.43.9.46
IPVirtualDNS1=10.43.9.33
maskDNS1=255.255.255.240
portDNS1=29000

#config dns 2
IPFisicaDNS2=$IPDNS2
miIPVirtualDNS2=10.15.65.66
IPVirtualDNS2=10.15.65.65
maskDNS2=255.255.255.192
portDNS2=30000

#config dns root
IPFisicaDNSRoot=$IPDNSRoot
miIPVirtualDNSRoot=10.94.6.194
IPVirtualDNSRoot=10.94.6.193
maskDNSRoot=255.255.255.192
portDNSRoot=31000

#config telServer
IPFisicaTelServer=$servers
miIPVirtualTelServer=10.43.9.64
IPVirtualTelServer=10.43.9.65
maskTelServer=255.255.255.240
portTelServer=32000

#config webServer
IPFisicaWebServer=$servers
miIPVirtualWebServer=10.15.65.135
IPVirtualWebServer=10.15.65.136
maskWebServer=255.255.255.192
portWebServer=33000

#config FTPServer
IPFisicaFTPServer=$servers
miIPVirtualFTPServer=205.129.31.10
IPVirtualFTPServer=205.129.31.11
maskFTPServer=255.255.255.192
portFTPServer=34000


sudo tunctl -t tap1
exec sudo openvpn --port $portHost1 --remote $IPhost1 --dev tap1 --ifconfig $miIPVirtual1 $mask1 $IPVirtualHost1 & 
sudo ifconfig tap1 promisc

sudo tunctl -t tap2
exec sudo openvpn --port $portHost2 --remote $IPhost2 --dev tap2 --ifconfig $miIPVirtual2 $mask2 $IPVirtualHost2 & 
sudo ifconfig tap2 promisc

sudo tunctl -t tap3
exec sudo openvpn --port $portHost3 --remote $IPhost3 --dev tap3 --ifconfig $miIPVirtual3 $mask3 $IPVirtualHost3 & 
sudo ifconfig tap3 promisc

# DNS 1
sudo tunctl -t tap4
exec sudo openvpn --port $portDNS1 --remote $IPFisicaDNS1 --dev tap4 --ifconfig $miIPVirtualDNS1 $maskDNS1 $IPVirtualDNS1 & 
sudo ifconfig tap4 promisc

# DNS 2
sudo tunctl -t tap5
exec sudo openvpn --port $portDNS2 --remote $IPFisicaDNS2 --dev tap5 --ifconfig $miIPVirtualDNS2 $maskDNS2 $IPVirtualDNS2 & 
sudo ifconfig tap5 promisc

# DNS Root
sudo tunctl -t tap6
exec sudo openvpn --port $portDNSRoot --remote $IPFisicaDNSRoot --dev tap6 --ifconfig $miIPVirtualDNSRoot $maskDNSRoot $IPVirtualDNSRoot & 
sudo ifconfig tap6 promisc

#sevidor telServer
sudo tunctl -t tap7
exec sudo openvpn --port $portTelServer --remote $IPFisicaTelServer --dev tap7 --ifconfig $miIPVirtualTelServer $maskTelServer $IPVirtualTelServer & 
sudo ifconfig tap7 promisc

#sevidor WebServer
sudo tunctl -t tap8
exec sudo openvpn --port $portWebServer --remote $IPFisicaWebServer --dev tap8 --ifconfig $miIPVirtualWebServer $maskWebServer $IPVirtualWebServer & 
sudo ifconfig tap8 promisc

#sevidor FTP Server
sudo tunctl -t tap9
exec sudo openvpn --port $portFTPServer --remote $IPFisicaFTPServer --dev tap9 --ifconfig $miIPVirtualFTPServer $maskFTPServer $IPVirtualFTPServer & 
sudo ifconfig tap9 promisc