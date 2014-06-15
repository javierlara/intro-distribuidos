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
chequeoArchivo $serversConfig
servers=`cat $serversConfig`
chequeoIPValida $servers "los servers FTP telNet y webServer"

#limpio las configs
./borrarInterfaces.sh

#config host 1 sub red D
IPhost1=$IPhost
miIPVirtual1=10.94.5.195
IPVirtualHost1=10.94.5.194
mask1=255.255.255.192
portHost1=26000

#config host 2 sub red J
IPhost2=$IPhost
miIPVirtual2=10.94.5.148
IPVirtualHost2=10.94.5.149
mask2=255.255.255.240
portHost2=27000

#config host 3 sub red P
IPhost3=$IPhost
miIPVirtual3=10.15.65.100
IPVirtualHost3=10.15.65.101
mask3=255.255.255.224
portHost3=28000

#config dns 1  sub red n
IPFisicaDNS1=$IPDNS1
miIPVirtualDNS1=10.94.5.171
IPVirtualDNS1=10.94.5.161
maskDNS1=255.255.255.240
portDNS1=29000

#config dns 2  sub red b
IPFisicaDNS2=$IPDNS2
miIPVirtualDNS2=10.94.6.131
IPVirtualDNS2=10.94.6.130
maskDNS2=255.255.255.192
portDNS2=30000

#config dns root sub red r
IPFisicaDNSRoot=$IPDNSRoot
miIPVirtualDNSRoot=10.94.6.194
IPVirtualDNSRoot=10.94.6.193
maskDNSRoot=255.255.255.192
portDNSRoot=31000

#config telServer sub red B
IPFisicaTelServer=$servers
miIPVirtualTelServer=10.94.6.183
IPVirtualTelServer=10.94.6.182
maskTelServer=255.255.255.192
portTelServer=32000

#config telServer sub red S
IPFisicaTelServer2=$servers
miIPVirtualTelServer2=10.94.5.131
IPVirtualTelServer2=10.94.5.130
maskTelServer2=255.255.255.240
portTelServer2=35000

#config webServer  sub red Q
IPFisicaWebServer=$servers
miIPVirtualWebServer=205.129.31.10
IPVirtualWebServer=205.129.31.1
maskWebServer=255.255.255.192
portWebServer=33000

#config FTPServer  sub red G
IPFisicaFTPServer=$servers
miIPVirtualFTPServer=10.43.9.1
IPVirtualFTPServer=10.43.9.2
maskFTPServer=255.255.255.0
portFTPServer=34000


exec sudo openvpn --port $portHost1 --remote $IPhost1 --dev tap1 --ifconfig $miIPVirtual1 $mask1 $IPVirtualHost1 & 

exec sudo openvpn --port $portHost2 --remote $IPhost2 --dev tap2 --ifconfig $miIPVirtual2 $mask2 $IPVirtualHost2 & 

exec sudo openvpn --port $portHost3 --remote $IPhost3 --dev tap3 --ifconfig $miIPVirtual3 $mask3 $IPVirtualHost3 & 

# DNS 1
exec sudo openvpn --port $portDNS1 --remote $IPFisicaDNS1 --dev tap4 --ifconfig $miIPVirtualDNS1 $maskDNS1 $IPVirtualDNS1 & 

# DNS 2
exec sudo openvpn --port $portDNS2 --remote $IPFisicaDNS2 --dev tap5 --ifconfig $miIPVirtualDNS2 $maskDNS2 $IPVirtualDNS2 & 

# DNS Root
exec sudo openvpn --port $portDNSRoot --remote $IPFisicaDNSRoot --dev tap6 --ifconfig $miIPVirtualDNSRoot $maskDNSRoot $IPVirtualDNSRoot & 

#sevidor telServer
exec sudo openvpn --port $portTelServer --remote $IPFisicaTelServer --dev tap7 --ifconfig $miIPVirtualTelServer $maskTelServer $IPVirtualTelServer & 

#sevidor telServer2
exec sudo openvpn --port $portTelServer2 --remote $IPFisicaTelServer2 --dev tap10 --ifconfig $miIPVirtualTelServer2 $maskTelServer2 $IPVirtualTelServer2 & 

#sevidor WebServer
exec sudo openvpn --port $portWebServer --remote $IPFisicaWebServer --dev tap8 --ifconfig $miIPVirtualWebServer $maskWebServer $IPVirtualWebServer & 

#sevidor FTP Server
exec sudo openvpn --port $portFTPServer --remote $IPFisicaFTPServer --dev tap9 --ifconfig $miIPVirtualFTPServer $maskFTPServer $IPVirtualFTPServer & 
