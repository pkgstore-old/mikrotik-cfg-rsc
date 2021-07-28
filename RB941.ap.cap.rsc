# Model: RB941.
# Configuration: AP-CAP.
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www address=10.0.0.0/16
set ssh disabled=yes
set api disabled=yes
set winbox address=10.0.0.0/16
set api-ssl disabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity
set name=GW-HOME.38.02
/tool bandwidth-server
set enabled=no
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
