# docker-bind

A bind9 DNS server with your custom zones.

Additional informations:

- just give your zones as `volume`, they'll be copied where it should and loaded
- your zones must be named `domain.tld.hosts`
- if you don't want a zone to be loaded, just rename it without `.hosts` extension

## installation

	docker pull tvial/docker-bind

## build

	docker build -t tvial/docker-bind .

## docker-compose template

	bind:
	  image: tvial/docker-bind
	  volumes:
	    - ./zones:/data/zones
	  ports:
	    - "53:53/udp"

# wanna help?

Fork, improve and PR. ;-)