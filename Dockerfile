FROM ubuntu:14.04
MAINTAINER Thomas VIAL
RUN apt-get update -q
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install bind9 rsyslog dnsutils
VOLUME /etc/bind/zones
ADD start-bind.sh /usr/local/bin/start-bind.sh
RUN chmod +x /usr/local/bin/start-bind.sh
CMD /usr/local/bin/start-bind.sh
