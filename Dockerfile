FROM ubuntu:16.04
MAINTAINER Jordan Clark jordan.clark@esu10.org

ARG S6_OVERLAY_VERSION=1.20.0.0
ARG S6_OVERLAY_MD5HASH=86f62d1c3c7958fe244b4a864977bae8

COPY container-files /

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz && \
    echo "$S6_OVERLAY_MD5HASH *s6-overlay-amd64.tar.gz" | md5sum -c - && \
    tar xzf s6-overlay-amd64.tar.gz -C / && \
    rm s6-overlay-amd64.tar.gz

ENTRYPOINT ["/init"]
