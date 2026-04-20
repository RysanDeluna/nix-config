#!/bin/sh

IS_RUNNING=$(docker inspect -f '{{.State.Running}}' lute_docker-lute-1 2>/dev/null)
echo $IS_RUNNING
if [ "$IS_RUNNING" = "true" ]; then
    echo "Lute container is already running."
else
    docker compose -f ~/Desktop/lute_docker/docker-compose.yml up -d

    chromium --app=http://localhost:5001 & PID=$!
    wait $PID
    docker compose -f ~/Desktop/lute_docker/docker-compose.yml down
fi
