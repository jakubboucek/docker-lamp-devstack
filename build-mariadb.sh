#!/bin/bash

set -eux

### MariaDB - 10.3
MARIADB_RELEASE=30
docker pull mariadb:10.3.${MARIADB_RELEASE}
docker tag mariadb:10.3.${MARIADB_RELEASE} mariadb:10.3
docker run --rm mariadb:10.3 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.3 -t jakubboucek/lamp-devstack-mysql:10.3 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.3 --version
docker tag jakubboucek/lamp-devstack-mysql:10.3 jakubboucek/lamp-devstack-mysql:10.3
docker tag jakubboucek/lamp-devstack-mysql:10.3 jakubboucek/lamp-devstack-mysql:10.3.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.3.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.3

### MariaDB - 10.4
MARIADB_RELEASE=20
docker pull mariadb:10.4.${MARIADB_RELEASE}
docker tag mariadb:10.4.${MARIADB_RELEASE} mariadb:10.4
docker run --rm mariadb:10.4 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.4 -t jakubboucek/lamp-devstack-mysql:10.4 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.4 --version
docker tag jakubboucek/lamp-devstack-mysql:10.4 jakubboucek/lamp-devstack-mysql:10.4
docker tag jakubboucek/lamp-devstack-mysql:10.4 jakubboucek/lamp-devstack-mysql:10.4.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.4.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.4

### MariaDB - 10.5
MARIADB_RELEASE=11
docker pull mariadb:10.5.${MARIADB_RELEASE}
docker tag mariadb:10.5.${MARIADB_RELEASE} mariadb:10.5
docker run --rm mariadb:10.5 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.5 -t jakubboucek/lamp-devstack-mysql:10.5 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.5 --version
docker tag jakubboucek/lamp-devstack-mysql:10.5 jakubboucek/lamp-devstack-mysql:10.5
docker tag jakubboucek/lamp-devstack-mysql:10.5 jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.5

### MariaDB - 10.6
MARIADB_RELEASE=3
docker pull mariadb:10.6.${MARIADB_RELEASE}
docker tag mariadb:10.6.${MARIADB_RELEASE} mariadb:10.6
docker run --rm mariadb:10.6 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:10.6 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.6 --version
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:latest
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.6
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:latest
