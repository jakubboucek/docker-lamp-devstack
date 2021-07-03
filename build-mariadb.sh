#!/bin/bash

set -eux

### MariaDB - beta 10.6
docker pull mariadb:rc
docker run --rm mariadb:rc mysql --version
docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:rc mysql/
docker tag jakubboucek/lamp-devstack-mysql:rc jakubboucek/lamp-devstack-mysql:10-rc
docker tag jakubboucek/lamp-devstack-mysql:rc jakubboucek/lamp-devstack-mysql:10.6-rc
docker tag jakubboucek/lamp-devstack-mysql:rc jakubboucek/lamp-devstack-mysql:10.6.2-rc
docker push jakubboucek/lamp-devstack-mysql:10.6.2-rc
docker push jakubboucek/lamp-devstack-mysql:10.6-rc
docker push jakubboucek/lamp-devstack-mysql:10-rc
docker push jakubboucek/lamp-devstack-mysql:rc

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
