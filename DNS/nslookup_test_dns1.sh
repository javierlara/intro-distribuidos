red='\e[0;31m'
NC='\e[0m' 

echo "$(tput bold setaf 1)KITANA RED Q$(tput sgr0)"
echo WebServer Apache
nslookup 205.129.31.1
echo R17 interfaz1/0
nslookup 205.129.31.53
echo R16 interfaz2/0
nslookup 205.129.31.52
echo Nombres
echo WebServer Apache
nslookup "apache.matanza.baires.dc.fi.uba.ar." #apache
echo R17 interfaz1/0
nslookup "r17-1-kitana.matanza.baires.dc.fi.uba.ar." # R17 interfaz1/0
echo R16 interfaz2/0
nslookup "r16-2-kitana.matanza.baires.dc.fi.uba.ar." # R16 interfaz2/0

echo "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)MILENA RED P$(tput sgr0)"
echo IPS
echo R12 interfaz0/0
nslookup 10.15.65.114 #
echo R17 interfaz0/0
nslookup 10.15.65.115 #
echo R15 interfaz0/0
nslookup 10.15.65.116 #
echo Nombres
echo R12 interfaz0/0
nslookup "r12-0-milena.matanza.baires.dc.fi.uba.ar." # R12 interfaz0/0
echo R17 interfaz0/0
nslookup "r17-0-milena.matanza.baires.dc.fi.uba.ar." # R17 interfaz0/0
echo R15 interfaz0/0
nslookup "r15-0-milena.matanza.baires.dc.fi.uba.ar." # R15 interfaz0/0

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)SOFIA RED N$(tput sgr0)"
nslookup 10.94.5.172 # R15 interfaz 2/0
nslookup 10.94.5.173 # R16 interfaz 0/0
nslookup "r15-2-sofia.matanza.baires.dc.fi.uba.ar." # R15 interfaz 2/0
nslookup "r16-0-sofia.matanza.baires.dc.fi.uba.ar." # R16 interfaz 0/0

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)MACARENA RED O$(tput sgr0)"
nslookup 10.94.5.183 # R16 interfaz1/0
nslookup "r16-1-macarena.matanza.baires.dc.fi.uba.ar." # R16 interfaz1/0

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)CAROLINA RED K$(tput sgr0)"
nslookup 205.129.31.134 # R12 interfaz1/0
nslookup "r12-1-carolina.matanza.baires.dc.fi.uba.ar." # R12 interfaz1/0

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)FRAME RELAY R1-R15$(tput sgr0)"
nslookup 15.55.200.38
nslookup "r15-fr-r1.matanza.baires.dc.fi.uba.ar."

echo  "$(tput setaf 1)Press a key...$(tput sgr0)"
read 1

echo "$(tput bold setaf 1)FRAME RELAY R7-R15$(tput sgr0)"
nslookup 15.55.200.42
nslookup "r15-fr-r7.matanza.baires.dc.fi.uba.ar."