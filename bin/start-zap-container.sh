DOCKER_IMAGE="owasp-zap/certs-patched"
FOUND=$(docker images | grep  $DOCKER_IMAGE)
if  [ -z "$FOUND" ]; then
   DOCKER_IMAGE="owasp/zap2docker-stable"
fi
echo "Launcing docker container with image $DOCKER_IMAGE"
docker run -p 8080:8080 -i $DOCKER_IMAGE zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true -config api.disablekey=true