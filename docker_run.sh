#!/bin/bash
REPO="kilver"
IMAGE="projecteuler"
TAG="0.1"

docker run \
        -it \
        -w $HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $(pwd)/../ProjectEuler:/home/$(id -un)/ProjectEuler \
        -p 3000:3000 -p 8888:8888 -p 8086:8086 \
        -p 1883:1883 -p 9001:9001 \
        -e PATH=$PATH:$(pwd)/../ProjectEuler \
        --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
        --entrypoint ProjectEuler/run.sh \
        ${REPO}/${IMAGE}:${TAG}
        