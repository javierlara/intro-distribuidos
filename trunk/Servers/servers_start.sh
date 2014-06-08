#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "Debe ejecutar como administrador"
   exit 1
fi

case "$1" in

	#FTP 
	ftp)
	ps -ef | grep "vsftpd" | grep -v "grep" > /dev/null
	if [ "$?" -eq "0" ]
	then
		echo "El FTP está corriendo."
		case "$2" in
		stop)
			service vsftpd stop
			echo "Stopping FTP"
		;;
		esac
		exit
	fi

	echo "El FTP no esta corriendo."
	case "$2" in	
		start)
			service vsftpd start	
			echo "Iniciando FTP.."
		;;
		esac
	;;
esac
