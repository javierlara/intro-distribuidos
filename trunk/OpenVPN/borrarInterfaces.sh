#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "Debe ejecutar como administrador"
   exit 1
fi

interfaces="tap1 tap2 tap3 tap4 tap5 tap6 tap7 tap8 tap9 tap10"

for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
done

sudo pkill openvpn
