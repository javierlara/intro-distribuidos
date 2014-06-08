#!/bin/bash
SRV="srv"
ETC="etc"

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
