FROM owasp/zap2docker-stable
USER root
RUN mkdir -p /tmp/corporateCerts
COPY "certs/*.crt" /tmp/corporateCerts
RUN apt-get update
RUN apt-get install ca-certificates -y
RUN cp /tmp/corporateCerts/*.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
USER zap