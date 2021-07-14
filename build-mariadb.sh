#!/bin/bash

set -eux

### MariaDB - 10.5
MARIADB_RELEASE=11
docker pull mariadb:10.5.${MARIADB_RELEASE}
docker tag mariadb:10.5.${MARIADB_RELEASE} mariadb:10.5
docker run --rm mariadb:10.5 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.5 -t jakubboucek/lamp-devstack-mysql:10.5 mysql/
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.5
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.5

### MariaDB - 10.6
MARIADB_RELEASE=3
docker pull mariadb:10.6.${MARIADB_RELEASE}
docker tag mariadb:10.6.${MARIADB_RELEASE} mariadb:10.6
docker run --rm mariadb:10.6 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:10.6 mysql/
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:latest
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.6
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:latest
