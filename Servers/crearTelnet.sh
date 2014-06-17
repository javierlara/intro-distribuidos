#!/bin/sh
case "$1" in
	init)
	ETC="etc"
	echo "Instalando Telnet"
	apt-get install telnetd
	apt-get install xinetd
	cp -r /$ETC/xinetd.d/ ~/aux/
	cp Telnet/telnet /$ETC/xinetd.d/

	;;
	start)
	echo "Iniciando Telnet"
	service xinetd start	
	;;
	
	stop)
	echo "Stopping Telnet"
	service xinetd stop

	;;
	
esac