Instalar

En Fedora:

#yum install telnet-server telnet
#yum install xinetd

Para hacerlo funcionar (esta parte solo es la primera vez que instalan):

#systemctl enable telnet.socket
#systemctl start telnet.socket
#firewall-cmd --permanent --add-service=telnet
#firewall-cmd --reload
*********************************************************
Luego correr el script ./configureTelnetServer


