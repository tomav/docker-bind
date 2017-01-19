FROM ubuntu:14.04
MAINTAINER Thomas VIAL
RUN apt-get update -q && \
  apt-get -y upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install bind9 rsyslog dnsutils && \
  chmod +x /usr/local/bin/start-bind.sh && \
  sed -i '/options {/a\\tallow-recursion { localnets; localhost; };\n\tallow-query-cache { any; };\n\tforwarders { 8.8.8.8; 8.8.4.4; };\n\tallow-query { any; };\n' /etc/bind/named.conf.options && \
  rm -rf /var/lib/apt/lists/*
VOLUME /etc/bind/zones
CMD /usr/local/bin/start-bind.sh
