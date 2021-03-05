### MariaDB
docker pull mariadb:10.4
docker run --rm mariadb:10.4 mysql --version
docker build --progress plain --no-cache -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql:latest mysql/
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4.x
docker push jakubboucek/lamp-devstack-mysql:latest
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:10.4
docker push jakubboucek/lamp-devstack-mysql:10.4.x
