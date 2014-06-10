#!/bin/sh

#verifico permisos
if [ "$(id -u)" != "0" ]; then
	echo "Debe ejecutar como administrador"
	exit 1
fi

chequeoDirectorio(){
	dirName=${1}
	if [ ! -d "$dirName" ]; then
	    echo "El directorio $dirName no existe"
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
function start_bind9 {
	echo "Starting bind9"
	/etc/init.d/bind9 restart

	if [ "$?" != "0" ];then 
		exit_conf "3" "Error iniciando bind9"
	fi
	return 0
}
#chequeoPrograma "bind"


#copiar la configuración a el bind

bindPath="/etc/bind/"
chequeoDirectorio $bindPath
	if [ -d "$bindPath*" ]; then
	    rm -R "$bindPath*"
	fi

cp bind_root/* $bindPath

start_bind9