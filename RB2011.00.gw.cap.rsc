# Model: RB2011.
# Configuration: GW-CAP.
:delay 30s
/caps-man channel
add band=2ghz-b/g/n frequency=2412 name=ap.01 tx-power=20
add band=2ghz-b/g/n frequency=2417 name=ap.02 tx-power=20
add band=2ghz-b/g/n frequency=2437 name=ap.03 tx-power=20
add band=2ghz-b/g/n comment=reserve frequency=2457 name=ap.04 tx-power=20
/interface bridge
add name=bridge1
/caps-man datapath
add bridge=bridge1 client-to-client-forwarding=yes local-forwarding=yes name=common
/caps-man security
add authentication-types=wpa2-psk encryption=aes-ccm name=common passphrase=EXAMPLE_PASS
/caps-man configuration
add channel=ap.01 country=russia datapath=common distance=indoors hw-protection-mode=rts-cts installation=indoor mode=ap name=ap.01 rx-chains=0,1,2 security=common ssid=GW-HOME.38 tx-chains=0,1,2
add channel=ap.02 country=russia datapath=common distance=indoors hw-protection-mode=rts-cts installation=indoor mode=ap name=ap.02 rx-chains=0,1,2 security=common ssid=GW-HOME.38 tx-chains=0,1,2
add channel=ap.03 country=russia datapath=common distance=indoors hw-protection-mode=rts-cts installation=indoor mode=ap name=ap.03 rx-chains=0,1,2 security=common ssid=GW-HOME.38 tx-chains=0,1,2
/interface list
add name=WAN
add name=LAN
/ip pool
add name=dhcp ranges=192.168.0.100-192.168.0.200
/ip dhcp-server
add address-pool=dhcp disabled=no interface=bridge1 name=dhcp1
/caps-man access-list
add action=reject allow-signal-out-of-range=10s comment="common: reject all" disabled=no mac-address=00:00:00:00:00:00 mac-address-mask=00:00:00:00:00:00 ssid-regexp=""
/caps-man manager
set enabled=yes
/caps-man manager interface
add disabled=no forbid=yes interface=ether1
/caps-man provisioning
add action=create-dynamic-enabled comment=common master-configuration=ap.01 name-format=prefix-identity
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
add bridge=bridge1 interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add interface=ether1 list=WAN
add interface=bridge1 list=LAN
/interface wireless cap
set discovery-interfaces=bridge1 enabled=yes interfaces=wlan1
/ip address
add address=192.168.0.1/24 interface=bridge1 network=192.168.0.0
/ip dhcp-client
add default-route-distance=10 disabled=no interface=ether1 use-peer-ntp=no
/ip dhcp-server network
add address=192.168.0.0/24 dns-server=1.1.1.1,1.0.0.1 domain=home.local gateway=192.168.0.1 netmask=24 ntp-server=129.6.15.28,129.6.15.29,129.6.15.30,132.163.96.1,132.163.96.2,132.163.96.3
/ip firewall filter
add action=accept chain=input comment=CAPsMAN dst-address-type=local src-address-type=local
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
set www address=192.168.0.0/24
set ssh disabled=yes
set api disabled=yes
set winbox address=192.168.0.0/24
set api-ssl disabled=yes
/lcd
set enabled=no
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity
set name=GW-HOME.38.01
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
