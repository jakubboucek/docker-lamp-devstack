# Building notes
Notes how to build new vestion of prepared images.

This note is not necessary for USE images, it's for BUILD him. 

### PHP 7.4
```shell
docker pull php:7.4-apache
docker run --rm php:7.4-apache php --version
docker build --progress plain -f php/Dockerfile -t jakubboucek/lamp-devstack-php:latest php/
docker build --progress plain -f php/Dockerfile-debug -t jakubboucek/lamp-devstack-php:debug php/
docker run --rm jakubboucek/lamp-devstack-php:latest php --version
docker run --rm jakubboucek/lamp-devstack-php:debug php --version
docker tag jakubboucek/lamp-devstack-php:latest jakubboucek/lamp-devstack-php:7
docker tag jakubboucek/lamp-devstack-php:latest jakubboucek/lamp-devstack-php:7.4
docker tag jakubboucek/lamp-devstack-php:latest jakubboucek/lamp-devstack-php:7.4.x
docker tag jakubboucek/lamp-devstack-php:debug jakubboucek/lamp-devstack-php:7-debug
docker tag jakubboucek/lamp-devstack-php:debug jakubboucek/lamp-devstack-php:7.4-debug
docker tag jakubboucek/lamp-devstack-php:debug jakubboucek/lamp-devstack-php:7.4.x-debug
docker push jakubboucek/lamp-devstack-php:latest
docker push jakubboucek/lamp-devstack-php:7
docker push jakubboucek/lamp-devstack-php:7.4
docker push jakubboucek/lamp-devstack-php:7.4.x
docker push jakubboucek/lamp-devstack-php:debug
docker push jakubboucek/lamp-devstack-php:7-debug
docker push jakubboucek/lamp-devstack-php:7.4-debug
docker push jakubboucek/lamp-devstack-php:7.4.x-debug
```

### PHP 7.3
```shell
docker pull php:7.3-apache
docker run --rm php:7.3-apache php --version
docker build --progress plain -f php/Dockerfile-7.3 -t jakubboucek/lamp-devstack-php:7.3 php/
docker build --progress plain -f php/Dockerfile-7.3-debug -t jakubboucek/lamp-devstack-php:7.3-debug php/
docker run --rm jakubboucek/lamp-devstack-php:7.3 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3-debug php --version
docker tag jakubboucek/lamp-devstack-php:7.3 jakubboucek/lamp-devstack-php:7.3.x
docker tag jakubboucek/lamp-devstack-php:7.3-debug jakubboucek/lamp-devstack-php:7.3.x-debug
docker push jakubboucek/lamp-devstack-php:7.3
docker push jakubboucek/lamp-devstack-php:7.3.x
docker push jakubboucek/lamp-devstack-php:7.3-debug
docker push jakubboucek/lamp-devstack-php:7.3.x-debug
```

### PHP 8.0
```shell
docker pull php:8.0-apache
docker run --rm php:8.0-apache php --version
docker build --progress plain -f php/Dockerfile-8.0 -t jakubboucek/lamp-devstack-php:8.0 php/
docker build --progress plain -f php/Dockerfile-8.0-debug -t jakubboucek/lamp-devstack-php:8.0-debug php/
docker run --rm jakubboucek/lamp-devstack-php:8.0 php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0-debug php --version
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8.0.x
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8-debug
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8.0.x-debug
docker push jakubboucek/lamp-devstack-php:8
docker push jakubboucek/lamp-devstack-php:8.0
docker push jakubboucek/lamp-devstack-php:8.0.x
docker push jakubboucek/lamp-devstack-php:8-debug
docker push jakubboucek/lamp-devstack-php:8.0-debug
docker push jakubboucek/lamp-devstack-php:8.0.x-debug
```

### MariaDB
```shell
docker pull mariadb:10.4
docker run --rm mariadb:10.4 mysql --version
docker build -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql:latest mysql/
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4.x
docker push jakubboucek/lamp-devstack-mysql:latest
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:10.4
docker push jakubboucek/lamp-devstack-mysql:10.4.x
```
