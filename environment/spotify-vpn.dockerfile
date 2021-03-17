FROM ubuntu:20.04

LABEL maintainer="Julio Gutierrez"

#To install without any interactive dialogue
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV PULSE_SERVER=unix:/var/run/pulseaudio.sock
ENV PULSE_COOKIE=/run/pulse/cookie

RUN apt-get update -yqq && \
	apt-get install -yqq curl jq wget gnupg libcanberra-gtk-module libcanberra-gtk3-module && \
    apt-get autoclean -yqq && \
    apt install pulseaudio libpulse0 libasound2-plugins -yqq &&\
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