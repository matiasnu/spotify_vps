#!/bin/bash
CONTAINERS=5
xhost local:root
for i in $(seq 1 6);do SPOTIFY_INDEX=$i docker-compose -p spotify_environment_$i up --force-recreate --build -d spotify ;done