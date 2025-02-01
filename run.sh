#!/bin/bash
# Script to keep track of docker run args
IMAGE_NAME="ros-jazzy"
docker build -t $IMAGE_NAME ~/robotics/Docker
docker run -it --user=ubuntu \
    --volume ~/robotics:/robotics \
    --network=host --ipc=host --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --env=DISPLAY --device=/dev/dri\
    $IMAGE_NAME