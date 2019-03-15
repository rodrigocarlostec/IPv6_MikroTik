
CRIAÇÃO DE POOLS IPV6 (FAZER DIVISÃO EM DOIS /52 USANDO http://www.gestioip.net/cgi-bin/subnet_calculator.cgi)

OK

/ipv6 pool
add name=IPV6-DHCPV6-PD prefix=2804:0ad8:0000:4000:0000:0000:0000:0000/52 prefix-length=56
add name=IPV6-PREFIX prefix=2804:0ad8:0000:5000:0000:0000:0000:0000/52 prefix-length=64

ADIÇÃO DOS POOLS NO PROFILE IPV6 NO PROFILE PPPOE

OK

/ppp profile
set *0 dns-server=195.128.124.181,195.128.124.150
add dhcpv6-pd-pool=IPV6-DHCPV6-PD dns-server=177.66.116.50,177.66.116.60 \
    local-address=pool-local name=pppoe remote-address=pool-remote \
    remote-ipv6-prefix-pool=IPV6-PREFIX

CONFIGURAÇÃO DE ROTEAMENTO DE BLOCO IPV6

IPV6 DE SESSÃO

OK

/ipv6 address
add address=fd46:cbf9:f294:ac38::/127 advertise=no interface=vlan-1152

ROTA DEFAULT

OK

/ipv6 route
add distance=1 gateway=fd46:cbf9:f294:ac38::1

CONFIGURAÇÃO DE ROTEAMENTO

OK

/routing bgp instance
set default as=262494

OK

/routing bgp network
add comment=BLOCO-CLIENTES network=2804:ad8:0:2000::/51 synchronize=no

OK

/routing bgp peer
add name=huawei-6720 remote-address=172.16.255.9 remote-as=262494 ttl=default
add address-families=ip,ipv6 name=huawei-6720-ipv6 remote-address=\
    fd46:cbf9:f294:ac38::1 remote-as=262494 ttl=default

CONFIGURAÇÃO DO PPPOE-SERVER

/interface pppoe-server server
add default-profile=pppoe disabled=no interface=ether2 one-session-per-host=\
    yes service-name=PPPOE-SERVER

CONFIGURAÇÃO DE DNS IPV6 E IPV4

OK

/ip dns
set servers=177.66.116.50,177.66.116.40,2804:ad8::a,2804:ad8::b