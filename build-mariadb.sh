#!/bin/bash

set -eux

### MariaDB - beta 10.6
docker pull mariadb:beta
docker run --rm mariadb:beta mysql --version
docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:beta mysql/
docker tag jakubboucek/lamp-devstack-mysql:beta jakubboucek/lamp-devstack-mysql:10-beta
docker tag jakubboucek/lamp-devstack-mysql:beta jakubboucek/lamp-devstack-mysql:10.6-beta
docker tag jakubboucek/lamp-devstack-mysql:beta jakubboucek/lamp-devstack-mysql:10.6.1-beta
docker push jakubboucek/lamp-devstack-mysql:10.6.1-beta
docker push jakubboucek/lamp-devstack-mysql:10.6-beta
docker push jakubboucek/lamp-devstack-mysql:10-beta
docker push jakubboucek/lamp-devstack-mysql:beta

### MariaDB
docker pull mariadb:10.5
docker run --rm mariadb:10.5 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.5 -t jakubboucek/lamp-devstack-mysql:latest mysql/
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.5
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.5.x
docker push jakubboucek/lamp-devstack-mysql:10.5.x
docker push jakubboucek/lamp-devstack-mysql:10.5
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:latest
