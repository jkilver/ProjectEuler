#!/bin/bash

REPO="kilver"
IMAGE="projecteuler"
TAG="0.1"

docker build --build-arg UID=$(id -u) \
             --build-arg GID=$(id -g) \
             --build-arg UNAME=$(id -un) \
             --tag ${REPO}/${IMAGE}:${TAG} \
             -f Dockerfile .