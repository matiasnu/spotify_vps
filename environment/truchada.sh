#!/bin/bash
CONTAINERS=2
xhost local:root

start() {
    for i in $(seq 1 ${CONTAINERS});do SPOTIFY_INDEX=$i docker-compose -p environment_$i up --force-recreate --build -d spotify ;done
}

stop() {
    for i in $(seq 1 ${CONTAINERS});do 
    docker exec -it environment${i}_spotify_1 nordvpn disconnect
    docker stop environment${i}_spotify_1
    docker rm environment${i}_spotify_1 ;done
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