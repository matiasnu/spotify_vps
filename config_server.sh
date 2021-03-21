#!/bin/bash

# Set environment variables
# Username and password from github
username=
password=

# Install go in the server in /root path
func golang_install() {
    cd ~
    curl -O https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
    tar -xvf go1.12.1.linux-amd64.tar.gz -C /usr/local 
    chown -R root:root /usr/local/go
    mkdir -p $HOME/go/{bin,src}
    echo -e "export GOPATH=$HOME/go\nexport PATH=$PATH:$GOPATH/bin\nexport PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.profile
    . ~/.profile
}

# Clone spotify_service in the server
func build_service () {
    cd /root/go/src/
    git clone https://${username}:${password}@github.com/guidoperre/spotify-service.git
    cd spotify-service
    go mod init
    go build
}

# Clone spotify_vps in the server
func build_environment_spotify() {
    cd /home/truchada/
    git clone -b only_spotify https://${username}:${password}@github.com/Matiasnu/spotify_vps.git
    cd spotify_vps/environment
    ./truchada start
}

# Install docker in the server
func docker_install() {
    apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    apt update
    apt-cache policy docker-ce
    apt install docker-ce
    usermod -aG docker truchada
}

# Install docker-compose in the server
func docker_compose_install() {
    curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

func grafic_install() {
    useradd -m truchada && passwd truchada
    apt update && apt upgrade -y && apt install ubuntu-desktop -y && init 6
}

# Install basic tools
func basic_install() {
    apt install curl
    apt install git
}

# Run vps prepare
apt update
basic_install
grafic_install
docker_install
docker_compose_install
golang_install
build_service
build_environment_spotify