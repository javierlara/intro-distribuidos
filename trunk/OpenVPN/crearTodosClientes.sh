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
serverConfig="serverIp.conf"
if [ ! -f "$serverConfig" ]; then
    echo "El archivo $serverConfig no existe, copiar el $serverConfig.sample a $serverConfig y poner la IP fisica del modelo"
    exit 1
fi

# Me aseguro que los scripts sean ejecutables
echo "Iniciando clientes"
chmod 775 Clientes/crearInterfazClienteA.sh
chmod 775 Clientes/crearInterfazClienteB.sh
chmod 775 Clientes/crearInterfazClienteC.sh
echo "."
#Conectar a los clientes
./Clientes/crearInterfazClienteA.sh &
echo "."
./Clientes/crearInterfazClienteB.sh &
echo "."
./Clientes/crearInterfazClienteC.sh &
echo "."
echo "Clientes corriendo"