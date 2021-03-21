#!/bin/bash
CONTAINERS=18
xhost local:root
GROUPADD=$(getent group audio | cut -d: -f3)

start() {
    docker stack deploy -c docker-compose.yml spotify_service
    for i in $(seq 1 ${CONTAINERS});do SPOTIFY_INDEX=$(generate_hostname) USERID=$(id -u) docker-compose -p environment_$i up --force-recreate --build -d spotify ;done
}

stop() {
    for i in $(seq 1 ${CONTAINERS});do 
    docker stop environment_${i}_spotify_1
    docker rm environment_${i}_spotify_1 ;done
    docker stack down spotify_service
}

generate_hostname() {
    result=$(tr -dc A-Z0-9 < /dev/urandom | head -c 7 | xargs)
    echo "$result"
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
