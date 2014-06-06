#!/bin/sh
#magia


cambiosIps="cambioips.list"
procesar(){
	file=${1}
	cat $file | sed "s/\(.*[^_][^_]\|^\)\($viejaIpAux\)\(.*[^_][^_]\|$\)/\1$nuevaIPAux\3/g" > "$file.back" ; mv "$file.back" $file
}
procesarTemp(){
	file=${1}
	cat $file | sed "s/\(.*\)\($vieja$viejaIpAux$vieja\)\(.*\)/\1$nuevaIPAux\3/g" > "$file.back" ; mv "$file.back" $file;
}
recorrer(){
lista=${1}*
for elemento in $lista
do
	if [ -d "$elemento" ]; then
  		recorrer "$elemento/"
  	else
  		if [ -s "$elemento" ]; then
	    	echo "Processing $elemento"
	    	procesar $elemento
		fi
	fi
done

}

cambioATempIp(){
	viejaIp=${1}
	nuevaIP=${2}
	viejaIpAux=$viejaIp
	nuevaIPAux="$vieja$nuevaIP$vieja"
	procesar "OpenVPN/hosts.conf2"
	#recorrer ""
}
cambioANuevaIp(){
	viejaIp=${1}
	nuevaIP=${2}
	
	viejaIpAux="$nuevaIP"
	nuevaIPAux="$nuevaIP"
	procesarTemp "OpenVPN/hosts.conf3"
	#recorrer ""
}
vieja="__"
`cat OpenVPN/hosts.conf >  OpenVPN/hosts.conf2`

while read line
do
    viejo=`echo $line | sed 's/\(.*\),.*/\1/'`
    nuevo=`echo $line | sed 's/.*,\(.*\)/\1/'`
    echo "pasando IP $viejo -> temp$nuevo"
    cambioATempIp $viejo $nuevo
done < $cambiosIps
while read line
do
    viejo=`echo $line | sed 's/\(.*\),.*/\1/'`
    nuevo=`echo $line | sed 's/.*,\(.*\)/\1/'`
    echo "pasando IP $viejo -> temp$nuevo"
    cambioATempIp $viejo $nuevo
done < $cambiosIps
`cat OpenVPN/hosts.conf2 >  OpenVPN/hosts.conf3`
while read line
do
    viejo=`echo $line | sed 's/\(.*\),.*/\1/'`
    nuevo=`echo $line | sed 's/.*,\(.*\)/\1/'`
    echo "pasando IP temp$nuevo -> $nuevo"
    cambioANuevaIp $viejo $nuevo
done < $cambiosIps