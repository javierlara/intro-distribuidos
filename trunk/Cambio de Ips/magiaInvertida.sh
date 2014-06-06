	#!/bin/sh
	#magia

	# path de inicio
	path="intro-distribuidos"
	# archivo con listado de ips
	cambiosIps="cambioips.list"

	procesar(){
		file=${1}
		cat $file | sed "s/\(.*[^_][^_]\|^\)\($viejaIpAux\)\([^_][^_].*\|$\)/\1$nuevaIPAux\3/g" > "$file.back" ; mv "$file.back" $file
	}
	procesarTemp(){
		file=${1}
		cat $file | sed "s/\(.*\)\($viejaIpAux\)\(.*\)/\1$nuevaIPAux\3/g" > "$file.back" ; mv "$file.back" $file;
	}


	
	recorrer(){
	lista=${1}*

	for elemento in $lista;do
		if [ -d "$elemento" ]; then
			recorrer "$elemento/"
		else
			if [ -s "$elemento" ]; then
			echo "Processing $elemento"
			#procesar $elemento
			cambioATempIp $elemento
			cambioANuevaIp $elemento
			fi
		fi
	done

	}

	cambioATempIp(){
		file=${1}
		while read line; do
			viejo=`echo $line | sed 's/\(.*\),.*/\1/'`
			nuevo=`echo $line | sed 's/.*,\(.*\)/\1/'`
#			echo "pasando IP $viejo -> temp$nuevo"

			viejaIp=$viejo
			nuevaIP=$nuevo
			viejaIpAux=$viejaIp
			nuevaIPAux="$vieja$nuevaIP$vieja"

			procesar $file
		done < $cambiosIps
	}
	cambioANuevaIp(){
		file=${1}
		while read line; do
			viejo=`echo $line | sed 's/\(.*\),.*/\1/'`
			nuevo=`echo $line | sed 's/.*,\(.*\)/\1/'`
#			echo "pasando IP $viejo -> temp$nuevo"

			viejaIp=$nuevo
			nuevaIP=$nuevo
			viejaIpAux=$vieja$nuevaIP$vieja
			nuevaIPAux="$nuevaIP"
			procesarTemp $file
		done < $cambiosIps
	}
	vieja="__"

	#nuevo recorrer
	recorrer $path
	