#!/bin/bash
CONTAINERS=1
xhost local:root
for i in(seq 1 $CONTAINERS);do SPOTIFY_INDEX=$i docker-compose up --force-recreate --build -d --scale spotify=$i;done