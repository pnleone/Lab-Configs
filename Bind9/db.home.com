$TTL    604800
@       IN      SOA     bind.home.com. pnleone.outlook.com. (
                         2025082701     ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      bind.home.com.
bind    IN      A       192.168.1.251

; Hosts in 192.168.1.0/24 subnet
pihole  IN      A       192.168.1.250
unbound IN      A       192.168.1.252
router  IN      A       192.168.1.1
officepc IN     A       192.168.1.31
pf      IN      A       192.168.1.254
pfa     IN      A       192.168.1.253
pfb     IN      A       192.168.1.249
win11vm1 IN     A       192.168.1.202
kali    IN      A       192.168.1.100
web     IN      A       192.168.1.108
plex    IN      A       192.168.1.136
jellyfin IN     A       192.168.1.244
uptimek IN      A       192.168.1.181
vault   IN      A       192.168.1.4
wazuh   IN      A       192.168.1.219
pve     IN      A       192.168.1.178
portainer IN    A       192.168.1.126
tautulli IN     A       192.168.1.126
traefik IN      A       192.168.1.247
dc01    IN      A       192.168.1.152
win11pro IN     A       192.168.1.202
winn11pro2 IN   A       192.168.1.182
splunk  IN      A       192.168.1.109
ans     IN      A       192.168.1.25
piholebk IN     A       192.168.1.126
grafana IN      A       192.168.1.246
prom    IN      A       192.168.1.126
authentik IN    A       192.168.1.166
ds      IN      A       192.168.1.5
whoami  IN      A       192.168.1.247
pbs     IN      AD      192.168.1.239

; Hosts in 192.168.100.0/24 subnet
fw      IN      A       192.168.100.1
fwa     IN      A       192.168.100.2
fwb     IN      A       192.168.100.3
win11pfs IN     A       192.168.100.11
host1   IN      A       192.168.100.4
rootca  IN      A       192.168.100.50
stepca  IN      A       192.168.100.51
ovrsr   IN      A       192.168.100.15

; Hosts in 192.168.200.0/24 subnet
host2   IN      A       192.168.200.5

;dc._msdcs.home.com. IN NS      dc01.home.com.
; Required SRV Records for AD
;$ORIGIN home.com.
;_kerberos._tcp IN SRV 0 100 88  dc01.home.com.
;_kerberos._udp IN SRV 0 100 88  dc01.home.com.
;_ldap._tcp     IN SRV 0 100 389 dc01.home.com.

; Optional: Global Catalog
;_gc._tcp       IN SRV 0 100 3268 dc01.home.com.