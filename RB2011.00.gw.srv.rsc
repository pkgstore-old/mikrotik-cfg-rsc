# Model: RB2011.
# Configuration: GW-SRV.
:delay 30s
/interface bridge
add name=bridge1
/interface list
add name=WAN
add name=LAN
/ip pool
add name=dhcp ranges=10.0.9.1-10.0.9.254
/ip dhcp-server
add address-pool=dhcp disabled=no interface=bridge1 name=dhcp1
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
add bridge=bridge1 interface=ether6
add bridge=bridge1 interface=ether7
add bridge=bridge1 interface=ether8
add bridge=bridge1 interface=ether9
add bridge=bridge1 interface=ether10
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add interface=ether1 list=WAN
add interface=bridge1 list=LAN
/ip address
add address=10.0.0.1/16 interface=bridge1 network=10.0.0.0
/ip dhcp-client
add default-route-distance=10 disabled=no interface=ether1 use-peer-ntp=no
/ip dhcp-server network
add address=10.0.0.0/16 dns-server=1.1.1.1,1.0.0.1 domain=home.local gateway=10.0.0.1 netmask=16 ntp-server=129.6.15.28,129.6.15.29,129.6.15.30,132.163.96.1,132.163.96.2,132.163.96.3
/ip firewall filter
add action=accept chain=input comment=main protocol=icmp
add action=accept chain=input comment=main connection-state=established
add action=accept chain=input comment=main connection-state=related
add action=fasttrack-connection chain=forward comment=fasttrack connection-state=established,related
add action=accept chain=forward comment=fasttrack connection-state=established,related
add action=drop chain=input in-interface-list=!LAN
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www address=10.0.0.0/16
set ssh disabled=yes
set api disabled=yes
set winbox address=10.0.0.0/16
set api-ssl disabled=yes
/lcd
set enabled=no
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity
set name=GW-SRV.01
/system ntp client
set enabled=yes server-dns-names=time.cloudflare.com
/tool bandwidth-server
set enabled=no
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
