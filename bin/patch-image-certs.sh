#!/bin/bash
DOCKER_IMAGE="owasp-zap/certs-patched"
if [ -d "$DIRECTORY" ]; then
    echo "certs directory found."
    exit 1
fi
if [ -z "$(ls -A ./certs)" ]; then 
    echo "No certs found in certs directory."
    exit 1
fi
 docker build -t $DOCKER_IMAGE  .
 echo "New docker image $DOCKER_IMAGE with updated certificates created"