# project42/s6-ubuntu

[![pipeline status](https://git.jordanclark.us/devops/s6-ubuntu-docker/badges/master/pipeline.svg)](https://git.jordanclark.us/devops/s6-ubuntu-docker/commits/master)

## Introduction
A docker image based on Ubuntu Linux with the s6 process supervisor

### What is Ubuntu Linux?

Ubuntu is a free and open source operating system and Linux distribution based on Debian. Ubuntu has a large community and is widely used from desktops to servers.

### What is the s6-overlay?
The [s6-overlay project](https://github.com/just-containers/s6-overlay) is a series of init scripts and utilities to ease creating Docker images using s6 as a process supervisor.  The s6-overlay makes it easy to take advantages of s6 while still operate like other Docker images.  The s6 init system provides many helpful tools to initialize and manage processes as the Docker container starts.

### Tags

| Tag | Description |
|---|---|
| latest | The most current build.  Images based on latest may change often an possibly could break.  Test your images |
| 18.04 | Latest Ubuntu 18.04 LTS series |
| 16.04 | Latest Ubuntu 16.04 LTS series |
| 18.04.1 | Ubuntu Linux 18.04.1 built on 2018-07-30 |
| 1.21.4.0 | Ubuntu 18.04 with S6 Overlay v1.21.4.0 built on 2018-07-09 |
| 1.20.0.0 | Ubuntu 16.04 with S6 Overlay v1.20.0.0 built on 2017-09-25 |

### Issues

I'm sure there are some but currently I'm unaware of current issues.  If you find an issue please let me know on [GitHub](https://github.com/p42/s6-ubuntu-docker/issues)

### Prerequisites

A working docker daemon would be helpful to utilize this image.

## How to use this image

This image is meant to be used as a base to build custom docker images from.  It's value is that it takes the base ubuntu linux image and adds the s6 Overlay.

### Usage

###### Running a quick ubuntu linux container

~~~
docker run --rm -ti project42/s6-ubuntu:latest bash
~~~

This will present you with a shell on fresh container that will stop and remove itself when you exit the container.

###### Dockerfile that is based of of this image.

~~~
FROM project42/s6-ubunut:latest

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y cowsay && \
    rm -rf /var/lib/apt/lists/*
    
ENTRYPOINT ["/init"]
~~~

## Configuration

### Configuration Parameters
| Environment | Description |
| --- | --- |
| TZ | Sets the container Timezone; example: CST6CDT default: UTC |  

## Maintenance

### Shell Access

This image includes the bash shell and when running in detached mode can be connected to with:

~~~
docker exec -ti <container> bash
~~~


## References

Maintainer: [https://jordanclark.us](https://jordanclark.us)

Maintainer's git repo: [https://git.jordanclark.us/devops/s6-ubuntu-docker](https://git.jordanclark.us/devops/s6-ubuntu-docker)

Github Issues: [https://github.com/p42/s6-ubuntu-docker/issues](https://github.com/p42/s6-ubuntu-docker/issues)

Ubuntu Linux: [https://www.ubuntu.com](https://www.ubuntu.com)

s6-overlay: [https://github.com/just-containers/s6-overlay](https://github.com/just-containers/s6-overlay)

s6 supervisor: [http://www.skarnet.org/software/s6/index.html](http://www.skarnet.org/software/s6/index.html)
