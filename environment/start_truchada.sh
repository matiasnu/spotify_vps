#!/bin/bash
CONTAINERS=1
xhost local:root
docker-compose up --force-recreate --build -d --scale spotify=$CONTAINERS