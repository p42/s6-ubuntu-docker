FROM ubuntu:rolling
MAINTAINER Jordan Clark mail@jordanclark.us

ARG S6_OVERLAY_VERSION=2.0.0.1
ARG S6_OVERLAY_MD5HASH=17f6115e23e9e86997c7e9aba1ed0717

COPY container-files /

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz && \
    echo "$S6_OVERLAY_MD5HASH *s6-overlay-amd64.tar.gz" | md5sum -c - && \
    tar xzf s6-overlay-amd64.tar.gz -C / --exclude='./bin' && \
    tar xzf s6-overlay-amd64.tar.gz -C /usr ./bin && \
    rm s6-overlay-amd64.tar.gz

ENTRYPOINT ["/init"]
