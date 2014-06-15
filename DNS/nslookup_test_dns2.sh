red='\e[0;31m'
NC='\e[0m'

echo "$(tput bold setaf 1)CARMEN RED H$(tput sgr0)"
echo R6 interfaz3/0
nslookup 205.129.31.129
echo R8 interfaz0/0
nslookup 205.129.31.130
echo Nombres
echo R6 interfaz3/0
nslookup "r6-3-carmen.varela.baires.dc.fi.uba.ar."
echo R8 interfaz0/0
nslookup "r8-0-patricia.laplata.baires.dc.fi.uba.ar."

echo "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)CAROLINA RED K$(tput sgr0)"
echo R13 interfaz2/0
nslookup 205.129.31.133
echo Nombres
echo R13 interfaz2/0
nslookup "r13-2-carolina.laplata.baires.dc.fi.uba.ar."

echo "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)TUNEL GRE$(tput sgr0)"
echo R10 tunel
nslookup 205.129.31.65
echo R11 tunnel
nslookup 205.129.31.66
echo Nombres
echo R10 tunnel
nslookup "r10-tunnel.laplata.baires.dc.fi.uba.ar."
echo R11 tunnel
nslookup "r11-tunnel.laplata.baires.dc.fi.uba.ar."

echo "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)PATRCIA RED J$(tput sgr0)"
echo IPS
echo HostB
nslookup 10.94.5.148
echo HostB prima
nslookup 10.94.5.149
echo R11 interfaz0/0
nslookup 10.94.5.153
echo R19 interfaz1/0
nslookup 10.94.5.154
echo R18 interfaz1/0
nslookup 10.94.5.155
echo Nombres
echo HostB
nslookup "hostb.laplata.baires.dc.fi.uba.ar."
echo HostB prima
nslookup "hostb-prima.laplata.baires.dc.fi.uba.ar."
echo R11 interfaz0/0
nslookup "r11-0-patricia.laplata.baires.dc.fi.uba.ar."
echo R19 interfaz1/0
nslookup "r9-1-patricia.laplata.baires.dc.fi.uba.ar."
echo R18 interfaz1/0
nslookup "r8-1-patricia.laplata.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)YESICA RED L$(tput sgr0)"
nslookup 10.15.65.80
nslookup 10.15.65.81
nslookup "r13-1-yesica.laplata.baires.dc.fi.uba.ar."
nslookup "r14-1-yesica.laplata.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)LUCILA RED G$(tput sgr0)"
nslookup 10.43.9.1
nslookup 10.43.9.245
nslookup 10.43.9.246
nslookup 10.43.9.247
nslookup 10.43.9.248
nslookup "r8-2-lucila.laplata.baires.dc.fi.uba.ar."
nslookup "r13-0-lucila.laplata.baires.dc.fi.uba.ar."
nslookup "r14-0-lucila.laplata.baires.dc.fi.uba.ar."
nslookup "r7-0-lucila.laplata.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)CECILIA RED I$(tput sgr0)"
nslookup 10.15.65.56
nslookup 10.15.65.57
nslookup "r10-2-cecilia.laplata.baires.dc.fi.uba.ar."
nslookup "r9-0-cecilia.laplata.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)FRAME RELAY R1-R7$(tput sgr0)"
nslookup 15.55.200.33
nslookup 15.55.200.34
nslookup "r1-fr-r7.varela.baires.dc.fi.uba.ar."
nslookup "r7-fr-r1.laplata.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)FRAME RELAY R1-R15$(tput sgr0)"
nslookup 15.55.200.37
nslookup "r1-fr-r15.varela.baires.dc.fi.uba.ar."


echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)FRAME RELAY R7-R15$(tput sgr0)"
nslookup 15.55.200.41
nslookup "r7-fr-r15.laplata.baires.dc.fi.uba.ar."

echo "$(tput bold setaf 1)LORENA RED D$(tput sgr0)"
echo IPS
echo HostA
nslookup 10.94.5.194
echo HostA prima
nslookup 10.94.5.195
echo R4 interfaz0/0
nslookup 10.94.5.241
echo R6 interfaz1/0
nslookup 10.94.5.242
echo R5 interfaz0/0
nslookup 10.94.5.243
echo VRRP
nslookup 10.94.5.244
echo Nombres
echo HostB
nslookup "hosta.varela.baires.dc.fi.uba.ar."
echo HostB prima
nslookup "hosta-prima.varela.baires.dc.fi.uba.ar."
echo R4 interfaz0/0
nslookup "r4-0-lorena.varela.baires.dc.fi.uba.ar."
echo R6 interfaz1/0
nslookup "r6-1-lorena.varela.baires.dc.fi.uba.ar."
echo R5 interfaz0/0
nslookup "r5-1-lorena.varela.baires.dc.fi.uba.ar."
echo VRRP
nslookup "vrrp-lorena.varela.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)CLEOPATRA RED R$(tput sgr0)"
echo IPS
echo R6 interfaz2/0
nslookup 10.94.6.224
echo DNS ROOT
nslookup 10.94.6.193
echo Nombres
echo R6 interfaz2/0
nslookup "r6-2-cleopatra.varela.baires.dc.fi.uba.ar."
echo DNS ROOT
nslookup "root-cleopatra.varela.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)MARTA RED B$(tput sgr0)"
echo IPS
echo R1 interfaz0/0
nslookup 10.94.6.168
echo R2 interfaz0/0
nslookup 10.94.6.169
echo R3 interfaz0/0
nslookup 10.94.6.170
echo Telnet tap 7
nslookup 10.94.6.129
echo DNS2
nslookup 10.94.6.130
echo DNS2 Prima
nslookup 10.94.6.131
echo Nombres
echo R1 interfaz0/0
nslookup "r1-0-marta.varela.baires.dc.fi.uba.ar."
echo R2 interfaz0/0
nslookup "r2-0-marta.varela.baires.dc.fi.uba.ar."
echo R3 interfaz0/0
nslookup "r3-0-marta.varela.baires.dc.fi.uba.ar."
echo Telnet tap 7
nslookup "telnet-tap7-marta.varela.baires.dc.fi.uba.ar."
echo DNS2
nslookup "dns2-marta.varela.baires.dc.fi.uba.ar."
echo DNS2 prima
nslookup "dns2-prima-marta.varela.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)SABRINA RED S$(tput sgr0)"
echo IPS
echo Telnet tap 10
nslookup 10.94.5.130
echo R3 interfaz2/0
nslookup 10.94.5.134
echo R5 interfaz0/0
nslookup 10.94.5.135
echo R6 interfaz0/0
nslookup 10.94.5.136
echo VRRP
nslookup 10.94.5.137
echo Nombres
echo Telnet tap 10
nslookup "telnet-tap10-sabrina.varela.baires.dc.fi.uba.ar."
echo R3 interfaz2/0
nslookup "r3-2-sabrina.varela.baires.dc.fi.uba.ar."
echo R5 interfaz0/0
nslookup "r5-0-sabrina.varela.baires.dc.fi.uba.ar."
echo R6 interfaz0/0
nslookup "r6-0-sabrina.varela.baires.dc.fi.uba.ar."
echo VRRP
nslookup "vrrp-sabrina.varela.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)VANESA RED C$(tput sgr0)"
echo IPS
echo R4 interfaz1/0
nslookup 10.15.65.192
echo R3 interfaz1/0
nslookup 10.15.65.193
echo Nombres
echo R4 interfaz1/0
nslookup "r4-1-vanesa.varela.baires.dc.fi.uba.ar."
echo R3 interfaz1/0
nslookup "r3-1-vanesa.varela.baires.dc.fi.uba.ar."