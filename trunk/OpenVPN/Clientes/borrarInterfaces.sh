#!/bin/sh

interfaces="tap1 tap2 tap3"

for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
done
sudo pkill openvpn
sleep 5