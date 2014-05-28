#!/bin/sh

interfaces="tap1 tap2 tap3 tap4"

for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
done
sleep 5
sudo pkill openvpn
sleep 5