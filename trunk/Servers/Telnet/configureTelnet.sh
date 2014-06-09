#!/bin/bash

# IP ADDRESS TELNET SERVER
TELNET_IP_1="10.94.5.130"
TELNET_BROADCAST_1="10.94.6.15"
TELNET_MASK_1="255.255.255.240"
TELNET_IP_2="10.94.6.129"
TELNET_BROADCAST_2="10.94.6.63"
TELNET_MASK_2="255.255.255.192"


# NETWORK ADDRESSES
NETWORK_A_ADDRESS="10.15.65.0"
NETWORK_B_ADDRESS="10.94.6.128"
NETWORK_C_ADDRESS="10.94.65.128"
NETWORK_D_ADDRESS="10.94.5.192"
NETWORK_G_ADDRESS="10.43.9.0"
NETWORK_H_ADDRESS="205.129.31.128"
NETWORK_I_ADDRESS="10.15.65.32"
NETWORK_J_ADDRESS="10.94.5.144"
NETWORK_K_ADDRESS="205.129.31.132"
NETWORK_L_ADDRESS="10.15.65.64"
NETWORK_N_ADDRESS="10.94.5.160"
NETWORK_O_ADDRESS="10.94.5.176"
NETWORK_P_ADDRESS="10.15.65.96"
NETWORK_Q_ADDRESS="205.129.31.0"
NETWORK_R_ADDRESS="10.94.6.192"
NETWORK_S_ADDRESS="10.94.5.128"

# NETWORK MASK
MASK_A="255.255.255.224"
MASK_B="255.255.255.192"
MASK_C="255.255.255.128"
MASK_D="255.255.255.192"
MASK_G="255.255.255.0"
MASK_H="255.255.255.252"
MASK_I="255.255.255.224"
MASK_J="255.255.255.240"
MASK_K="255.255.255.252"
MASK_L="255.255.255.224"
MASK_N="255.255.255.240"
MASK_O="255.255.255.240"
MASK_P="255.255.255.224"
MASK_Q="255.255.255.192"
MASK_R="255.255.255.192"
MASK_S="255.255.255.240"

# GATEWAYS TELNET SERVER
GATEWAY_A="10.94.6.169"		#R2
GATEWAY_B="10.94.5.135"		#VRRP R5-R6
GATEWAY_C="10.94.5.135"		#VRRP R5-R6
GATEWAY_D="10.94.5.135"		#VRRP R5-R6
GATEWAY_G="10.94.5.135"		#VRRP R5-R6
GATEWAY_H="10.94.5.135"		#VRRP R5-R6
GATEWAY_I="10.94.5.135"		#VRRP R5-R6
GATEWAY_J="10.94.5.135"		#VRRP R5-R6
GATEWAY_K="10.94.5.135"		#VRRP R5-R6
GATEWAY_L="10.94.5.135"		#VRRP R5-R6
GATEWAY_N="10.94.5.135"		#VRRP R5-R6
GATEWAY_O="10.94.5.135"		#VRRP R5-R6
GATEWAY_P="10.94.5.135"		#VRRP R5-R6
GATEWAY_Q="10.94.5.135"		#VRRP R5-R6
GATEWAY_R="10.94.5.136"		#VRRP R5-R6 (OJO QUIERO QUE VAYA con prioridad por 
										#el 6, por eso no pongoel 5)
GATEWAY_S="10.94.5.135"		#VRRP R5-R6

function getInterfaceName(){
	interface=`ifconfig | egrep "eth" | sed 's/^\([A-Za-z0-9:]*\).*/\1/'`
	echo "La interfaz es: $interface ... saliendo del obtnener nombre"
	echo
}
function deactivateAutomaticSOrouting(){
	echo "0" >> /proc/sys/net/ipv4/ip_forward
}
function configureInterfaceWithIpNetmaskAndBroadcast(){
	echo "ifconfig $1 $2 netmask $3 broadcast $4"
	echo
	ifconfig $1 $2 netmask $3 broadcast $4
}
function addRoute(){
	address=$1
	mask=$2
	gateway=$3
	echo "route add -net $address netmask $mask gw $gateway dev $interface"
	echo
	route add -net $address netmask $mask gw $gateway dev $interface 
}
function configureTelnetService(){
	cp inetd.conf.telnet /etc/inetd.conf
	service xinetd restart  
}
function configureTelnetServer(){
	configureInterfaceWithIpNetmaskAndBroadcast $interface $TELNET_IP_1 $TELNET_MASK_1 $TELNET_BROADCAST_1
	configureInterfaceWithIpNetmaskAndBroadcast $interface":0" $TELNET_IP_2 $TELNET_MASK_2 $TELNET_BROADCAST_2
	staticRouting
	configureTelnetService
}
function staticRouting(){
	echo "static routing"
	echo
	networkAddresses=( $NETWORK_A_ADDRESS $NETWORK_B_ADDRESS $NETWORK_C_ADDRESS $NETWORK_D_ADDRESS $NETWORK_G_ADDRESS $NETWORK_H_ADDRESS $NETWORK_I_ADDRESS $NETWORK_J_ADDRESS $NETWORK_K_ADDRESS $NETWORK_L_ADDRESS $NETWORK_N_ADDRESS $NETWORK_O_ADDRESS $NETWORK_P_ADDRESS $NETWORK_Q_ADDRESS $NETWORK_R_ADDRESS $NETWORK_S_ADDRESS )
	networkMasks=( $MASK_A $MASK_B $MASK_C $MASK_D $MASK_G $MASK_H $MASK_I $MASK_J $MASK_K $MASK_L $MASK_N $MASK_O $MASK_P $MASK_Q $MASK_R $MASK_S )
	gateways=( $GATEWAY_A $GATEWAY_B $GATEWAY_C $GATEWAY_D $GATEWAY_G $GATEWAY_H $GATEWAY_I $GATEWAY_J $GATEWAY_K $GATEWAY_L $GATEWAY_N $GATEWAY_O $GATEWAY_P $GATEWAY_Q $GATEWAY_R $GATEWAY_S )

	for ((i=0;i< ${#networkAddresses[@]};i++));do
		addRoute ${networkAddresses[$i]} ${networkMasks[$i]} ${gateways[$i]}
	done
}

getInterfaceName
deactivateAutomaticSOrouting
configureTelnetServer
