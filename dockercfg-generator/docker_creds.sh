#!/bin/sh

set -e

: "${DOCKER_USERNAME:?Need to set your DOCKER_USERNAME}"
: "${DOCKER_PASSWORD:?Need to set your DOCKER_PASSWORD}"
: "${DOCKER_REGISTRY:=https://index.docker.io/v1/}"

# Logging into the Docker registry
echo "Logging into registry at ${DOCKER_REGISTRY}"
docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}" "${DOCKER_REGISTRY}"

# writing docker creds to desired path
echo "Writing Docker creds to $1"
chmod 544 ~/.docker/config.json
cp ~/.docker/config.json $1
