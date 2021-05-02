#!/bin/bash

set -eux

### MariaDB - alpha 10.6
docker pull mariadb:10.6
docker run --rm mariadb:10.6 mysql --version
docker build --progress plain -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql:alpha mysql/
docker tag jakubboucek/lamp-devstack-mysql:alpha jakubboucek/lamp-devstack-mysql:10-alpha
docker tag jakubboucek/lamp-devstack-mysql:alpha jakubboucek/lamp-devstack-mysql:10.6-alpha
docker tag jakubboucek/lamp-devstack-mysql:alpha jakubboucek/lamp-devstack-mysql:10.6.0-alpha
docker push jakubboucek/lamp-devstack-mysql:10.6.0-alpha
docker push jakubboucek/lamp-devstack-mysql:10.6-alpha
docker push jakubboucek/lamp-devstack-mysql:10-alpha
docker push jakubboucek/lamp-devstack-mysql:alpha

### MariaDB
docker pull mariadb:10.5
docker run --rm mariadb:10.5 mysql --version
docker build --progress plain -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql:latest mysql/
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.5
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.5.x
docker push jakubboucek/lamp-devstack-mysql:10.5.x
docker push jakubboucek/lamp-devstack-mysql:10.5
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:latest
