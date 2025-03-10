#!/bin/bash

set -eux

cd "$(dirname $0)";

NO_PULL=${NO_PULL:-0}
NO_BUILD=${NO_BUILD:-0}
NO_TEST=${NO_TEST:-0}
NO_PUSH=${NO_PUSH:-0}

# Source: https://hub.docker.com/_/mariadb

### MariaDB - 10.5
MARIADB_RELEASE=28
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.5.${MARIADB_RELEASE}
    docker tag mariadb:10.5.${MARIADB_RELEASE} mariadb:10.5
    docker run --rm mariadb:10.5 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.5 -t jakubboucek/lamp-devstack-mysql:10.5 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.5 jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.5 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.5
fi


### MariaDB - 10.6
MARIADB_RELEASE=21
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.6.${MARIADB_RELEASE}
    docker tag mariadb:10.6.${MARIADB_RELEASE} mariadb:10.6
    docker run --rm mariadb:10.6 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:10.6 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.6 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.6
fi

### MariaDB - 10.11
MARIADB_RELEASE=11
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.11.${MARIADB_RELEASE}
    docker tag mariadb:10.11.${MARIADB_RELEASE} mariadb:10.11
    docker run --rm mariadb:10.11 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.11 -t jakubboucek/lamp-devstack-mysql:10.11 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.11 jakubboucek/lamp-devstack-mysql:10
    docker tag jakubboucek/lamp-devstack-mysql:10.11 jakubboucek/lamp-devstack-mysql:10.11.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.11 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.11.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.11
    docker push jakubboucek/lamp-devstack-mysql:10
fi

### MariaDB - 11.4
MARIADB_RELEASE=5
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:11.4.${MARIADB_RELEASE}
    docker tag mariadb:11.4.${MARIADB_RELEASE} mariadb:11.4
    docker run --rm mariadb:11.4 mariadb --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-11.4 -t jakubboucek/lamp-devstack-mysql:11.4 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:11.4 jakubboucek/lamp-devstack-mysql:11.4.${MARIADB_RELEASE}
    docker tag jakubboucek/lamp-devstack-mysql:11.4 jakubboucek/lamp-devstack-mysql:lts
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:11.4 mariadb --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:11.4.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:11.4
    docker push jakubboucek/lamp-devstack-mysql:lts
fi


### MariaDB - 11.7
MARIADB_RELEASE=2
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:11.7.${MARIADB_RELEASE}
    docker tag mariadb:11.7.${MARIADB_RELEASE} mariadb:11.7
    docker run --rm mariadb:11.7 mariadb --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-11.7 -t jakubboucek/lamp-devstack-mysql:11.7 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:11.7 jakubboucek/lamp-devstack-mysql:11.7.${MARIADB_RELEASE}
    docker tag jakubboucek/lamp-devstack-mysql:11.7 jakubboucek/lamp-devstack-mysql:11
    docker tag jakubboucek/lamp-devstack-mysql:11.7 jakubboucek/lamp-devstack-mysql:latest
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:11.7 mariadb --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:11.7.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:11.7
    docker push jakubboucek/lamp-devstack-mysql:11
    docker push jakubboucek/lamp-devstack-mysql:latest
fi


### MariaDB - 11.8
MARIADB_RELEASE=1
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:11.8.${MARIADB_RELEASE}-rc
    docker tag mariadb:11.8.${MARIADB_RELEASE}-rc mariadb:11.8-rc
    docker run --rm mariadb:11.8-rc mariadb --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-11.8 -t jakubboucek/lamp-devstack-mysql:11.8-rc mysql/
    docker tag jakubboucek/lamp-devstack-mysql:11.8-rc jakubboucek/lamp-devstack-mysql:11.8.${MARIADB_RELEASE}-rc
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:11.8-rc mariadb --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:11.8.${MARIADB_RELEASE}-rc
    docker push jakubboucek/lamp-devstack-mysql:11.8-rc
fi
