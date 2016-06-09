#!/bin/sh

echo "Copying zone files"
cp -r /data/zones /etc/bind/
chown root:bind /etc/bind/zones
chown root:root /etc/bind/rndc.key
chmod 755 /etc/bind/rndc.key

echo "Configuring 'named.conf.options'"
sed -i '/options {/a\\tallow-recursion { localnets; localhost; };\n\tallow-query-cache { any; };\n\tforwarders { 8.8.8.8; 8.8.4.4; };\n\tallow-query { any; };\n' /etc/bind/named.conf.options

echo "Generating 'named.conf.local'"
rm /etc/bind/named.conf.local
for file in /etc/bind/zones/*.hosts; do
echo '
  zone "'$(echo $file | sed 's/.hosts//g' | sed 's/\/etc\/bind\/zones\///g')'" {
    type master;
    file "'$file'";
  };' >> /etc/bind/named.conf.local
done

echo "Starting Syslog Server"
/etc/init.d/rsyslog restart
echo "Starting DNS Server"
/usr/sbin/named -c /etc/bind/named.conf -f