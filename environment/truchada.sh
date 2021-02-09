#!/bin/bash
I=1
TECHNOLOGY=NordLynx

start() {
xhost local:root
export SPOTIFY_INDEX=$I
export PROTOCOL=$TECHNOLOGY
docker-compose -p environment_${I} up --force-recreate --build -d spotify
}

stop() {
    docker exec -it environment${I}_spotify_1 nordvpn disconnect
    docker stop environment${I}_spotify_1
    docker rm environment${I}_spotify_1
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo $"Usage: $0 {start|stop}"
esac
