FROM ubuntu:18.04

LABEL maintainer="Julio Gutierrez"
ARG NORDVPN_VERSION=3.7.4

HEALTHCHECK --interval=5m --timeout=20s --start-period=1m \
	CMD if test $( curl -m 10 -s https://api.nordvpn.com/vpn/check/full | jq -r '.["status"]' ) = "Protected" ; then exit 0; else nordvpn connect ${CONNECT} ; exit $?; fi
#To install without any interactive dialogue
ENV DEBIAN_FRONTEND=noninteractive
ENV USER=perreguido@gmail.com
ENV PASS=guidosimon123
ENV CONNECT=Argentina
ENV TECHNOLOGY=NordLynx
ENV DISPLAY=:0

RUN addgroup --system vpn && \
	apt-get update -yqq && \
	apt-get install -yqq curl jq && \
	curl -s https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb --output /tmp/nordrepo.deb && \
    apt-get install -yqq /tmp/nordrepo.deb && \
    apt-get update -yqq && \
    apt-get install -yqq nordvpn${NORDVPN_VERSION:+=$NORDVPN_VERSION} && \
    apt-get remove -yqq nordvpn-release && \
    apt-get autoremove -yqq && \
    apt-get autoclean -yqq && \
    apt-get install curl wget gnupg -yqq &&\
    apt-get install libcanberra-gtk-module libcanberra-gtk3-module -yqq &&\
    rm -rf \
		/tmp/* \
		/var/cache/apt/archives/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

# Add the Spotify APT repository to your systems software repository list
RUN echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list

# Import the repositorys GPG key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys  D1742AD60D811D58

# Install Spotify
RUN apt-get update &&  apt-get install spotify-client -y

COPY start_vpn.sh /usr/bin
CMD /usr/bin/start_vpn.sh