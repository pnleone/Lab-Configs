$TTL    86400
$ORIGIN home.com.
@       IN      SOA     bind.home.com. pnleone.shadowitlab.com. (
                         2026021301     ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      bind.home.com.
bind    IN      A       192.168.1.251

; Hosts in 192.168.1.0/24 subnet
pihole  IN      A       192.168.1.247
unbound IN      A       192.168.1.252
router  IN      A       192.168.1.1
officepc IN     A       192.168.1.31
pf      IN      A       192.168.1.254
pfa     IN      A       192.168.1.253
pfb     IN      A       192.168.1.249
kali    IN      A       192.168.1.100
web     IN      A       192.168.1.89
plex    IN      A       192.168.1.247
uptimek IN      A       192.168.1.247
vault   IN      A       192.168.1.247
wazuh   IN      A       192.168.1.247
pve     IN      A       192.168.1.178
portainer IN    A       192.168.1.247
tautulli IN     A       192.168.1.247
trfk    IN      A       192.168.1.247
dc01    IN      A       192.168.1.152
win11pro IN     A       192.168.1.111
winn11pro2 IN   A       192.168.1.184
splunk  IN      A       192.168.1.247
ans     IN      A       192.168.1.25
piholebk IN     A       192.168.1.247
grafana IN      A       192.168.1.247
ubuntuvm1 IN    A       192.168.1.126
dockervm2 IN    A       192.168.1.166
ds      IN      A       192.168.1.5
whoami  IN      A       192.168.1.247
vas     IN      A       192.168.1.247
pbs     IN      A       192.168.1.243
pulse   IN      A       192.168.1.247
opn     IN      A       192.168.1.201
wud     IN      A       192.168.1.247
qbt     IN      A       192.168.1.247
n8n     IN      A       192.168.1.247
checkmk IN      A       192.168.1.247
cd      IN      A       192.168.1.247
dashbd  IN      A       192.168.1.247
r1      IN      A       192.168.1.6
sw1     IN      A       192.168.1.7
waf     IN      A       192.168.1.247
;lab     IN      A       192.168.1.89
cortex  IN      A       192.168.1.247
shuffle IN      A       192.168.1.247
authentik IN    A       192.168.1.166
prom    IN      a       192.168.1.166

; Hosts in 192.168.100.0/24 subnet
fw      IN      A       192.168.100.1
fwa     IN      A       192.168.100.2
fwb     IN      A       192.168.100.3
win11pfs IN     A       192.168.100.11
r1b     IN      A       192.168.100.6
rootca  IN      A       192.168.100.50
stepca  IN      A       192.168.100.51
ovrsr   IN      A       192.168.100.15
nessus  IN      A       192.168.100.5

; Hosts in 192.168.200.0/24 subnet
host2   IN      A       192.168.200.5
elastic IN      A       192.168.200.8
jellyfin IN     A       192.168.200.244
hive    IN      A       192.168.200.33
misp    IN      A       192.168.200.37
patch   IN      A       192.168.200.35
r1d     IN      A       192.168.200.6
test    IN      A       192.168.200.31
lab     IN      A       192.168.200.31

; Hosts in 192.168.2.0/24 subnet
pdf     IN      A       192.168.2.12
r1c     IN      A       192.168.2.6