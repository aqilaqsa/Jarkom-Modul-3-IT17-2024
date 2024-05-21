
#!/bin/bash

echo 'nameserver 10.72.3.1' >> /etc/resolv.conf   # Pastikan DNS Server sudah berjalan 
apt-get update
apt-get install isc-dhcp-server -y

interfaces="INTERFACESv4=\"eth0\"
INTERFACESv6=\"\"
"
echo "$interfaces" > /etc/default/isc-dhcp-server

subnet="option domain-name \"example.org\";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

ddns-update-style-none;

subnet 10.72.1.0 netmask 255.255.255.0 {
    range 10.72.1.14 10.72.1.28;
    range 10.72.1.49 10.72.1.70;
    option routers 10.72.1.0;
    option broadcast-address 10.72.1.255;
    option domain-name-servers 10.72.3.1;
    default-lease-time 300;
    max-lease-time 5220;
}

subnet 10.72.2.0 netmask 255.255.255.0 {
    range 10.72.2.15 10.72.2.25;
    range 10.72.2.200 10.72.2.210;
    option routers 10.72.2.0;
    option broadcast-address 10.72.2.255;
    option domain-name-servers 10.72.3.1;
    default-lease-time 1200;
    max-lease-time 5220;
}

subnet 10.72.3.0 netmask 255.255.255.0 {
}

subnet 10.72.4.0 netmask 255.255.255.0 {
}
"
echo "$subnet" > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart


# 12 - step 1
# ke /etc/dhcp/dhcpd.conf
# tambahkan
# DMITRI FIXED ADDRESS
# host Dmitri {
    # hardware ethernet 3a:80:a4:67:86:73;
    # fixed-address 10.72.1.37;
# }

# script:

echo 'nameserver 10.72.3.1' >> /etc/resolv.conf   # MAKE SURE DNS SERVER IRULAN IS RUNNING!!!
apt-get update
apt-get install isc-dhcp-server -y

# Set DHCP Server to listen on eth0
interfaces="INTERFACESv4=\"eth0\"
INTERFACESv6=\"\"
"
echo "$interfaces" > /etc/default/isc-dhcp-server

# Configure DHCP server
subnet="option domain-name \"example.org\";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

ddns-update-style none;

subnet 10.72.1.0 netmask 255.255.255.0 {
    range 10.72.1.14 10.72.1.28;
    range 10.72.1.49 10.72.1.70;
    option routers 10.72.1.0;
    option broadcast-address 10.72.1.255;
    option domain-name-servers 10.72.3.1;
    default-lease-time 300;
    max-lease-time 5220;
}

subnet 10.72.2.0 netmask 255.255.255.0 {
    range 10.72.2.15 10.72.2.25;
    range 10.72.2.200 10.72.2.210;
    option routers 10.72.2.0; 
    option broadcast-address 10.72.2.255;
    option domain-name-servers 10.72.3.1;
    default-lease-time 1200;
    max-lease-time 5220;
}

subnet 10.72.3.0 netmask 255.255.255.0 {
}

subnet 10.72.4.0 netmask 255.255.255.0 {
}
# DMITRI FIXED ADDRESS
host Dmitri {
    hardware ethernet 3a:80:a4:67:86:73; #eth0 (yg konek ke dhcp relay arakis)
    fixed-address 10.72.1.37;
}
"
echo "$subnet" > /etc/dhcp/dhcpd.conf

# Restart DHCP service to apply changes
service isc-dhcp-server restart

# note: hwaddr berubah2, config manually nano /etc/dhcp/dhcpd.conf
# lalu service isc-dhcp-server restart

