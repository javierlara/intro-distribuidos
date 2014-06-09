#!/bin/bash
SRV="srv"
ETC="etc"
APACHE="apache2"
VAR="var"

if [ "$(id -u)" != "0" ]; then
   echo "Debe ejecutar como administrador"
   exit 1
fi

mkdir ~/aux

	echo "Instalando FTP"
	apt-get install vsftpd
	echo "done"

	cp ftp/vsftpd.conf /$ETC/	# uso la configuracion vsftpd.conf
	cp -r /$SRV/ftp/ ~/aux/
	rm -r /$SRV/ftp/*

	cp -r ftp/$SRV/ftp /$SRV/
	
	
	echo "Instalando Apache"	
	apt-get install apache2

	mkdir /$ETC/$APACHE
	cp -r /$ETC/$APACHE/ ~/aux/
	cp -r /$VAR/www/ ~/aux/
	rm /$VAR/www/*
	cp -r web/$APACHE/ /$ETC/
	cp -r web/www/ /$VAR/
	chown -R $USER:$USER /var/www/
	chmod -R 755 /var/www/
