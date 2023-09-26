#!/bin/bash

docker stop chat-App-run
if [ $# -eq 0 ]; then
    docker rmi -f chat-app
else
    docker rmi -f chat-app:$1
fi
docker rm -f chat-App-run


#remove images
#docker rmi -f $(docker images -aq)

#remove container
#docker rm -f $(docker ps -a -q)
