ETC="etc"
	echo "Instalando Telnet"
	apt-get install telnetd
	apt-get install xinetd
	cp -r /$ETC/xinetd.d/ ~/aux/
	cp Telnet/telnet /$ETC/xinetd.d/

#	service xinetd stop

	service xinetd start	

	