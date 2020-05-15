# LAMP devstack as Docker 
Prepared images for local development in [LAMP devstack](https://en.wikipedia.org/wiki/LAMP_(software_bundle))

## Main features
- current version of PHP 7.4 and 7.3
- current version of Apache (with added [`mod_expires`](https://httpd.apache.org/docs/current/mod/mod_expires.html)
    and [`mod_rewrite`](https://httpd.apache.org/docs/current/mod/mod_rewrite.html) modules)
- current version of Maria 10  (with properly configured `utf8mb4` charset)
- optimized for small image size a fast load

## Usage
Just copy the [`docker-compose.yml`](docker-compose.yml) file to Your project's root and call `docker-compose up`.

It starts Apache which looks into `/www` directory in project as
[`DocumentRoot`](https://httpd.apache.org/docs/2.4/mod/core.html#documentroot), but for PHP is accesible whole project
directory.

When you want to use Xdebug, use [`docker-compose-debug.yml`](docker-compose-debug.yml), 

At the same time starts MySQL database server, ready to use. 

## Building notes
### PHP 7.4
- `docker pull php:7.4-apache`
- `docker run --rm php:7.4-apache php --version`
- `docker build -f php/Dockerfile -t jakubboucek/lamp-devstack-php:latest php/`
- `docker build -f php/Dockerfile-debug -t jakubboucek/lamp-devstack-php:debug php/`
- `docker run --rm jakubboucek/lamp-devstack-php:latest php --version`
- `docker run --rm jakubboucek/lamp-devstack-php:debug php --version`
- `docker tag jakubboucek/lamp-devstack-php:latest jakubboucek/lamp-devstack-php:7`
- `docker tag jakubboucek/lamp-devstack-php:latest jakubboucek/lamp-devstack-php:7.4`
- `docker tag jakubboucek/lamp-devstack-php:latest jakubboucek/lamp-devstack-php:7.4.x`
- `docker tag jakubboucek/lamp-devstack-php:debug jakubboucek/lamp-devstack-php:7-debug`
- `docker tag jakubboucek/lamp-devstack-php:debug jakubboucek/lamp-devstack-php:7.4-debug`
- `docker tag jakubboucek/lamp-devstack-php:debug jakubboucek/lamp-devstack-php:7.4.x-debug`
- `docker push jakubboucek/lamp-devstack-php:latest`
- `docker push jakubboucek/lamp-devstack-php:7`
- `docker push jakubboucek/lamp-devstack-php:7.4`
- `docker push jakubboucek/lamp-devstack-php:7.4.x`
- `docker push jakubboucek/lamp-devstack-php:debug`
- `docker push jakubboucek/lamp-devstack-php:7-debug`
- `docker push jakubboucek/lamp-devstack-php:7.4-debug`
- `docker push jakubboucek/lamp-devstack-php:7.4.x-debug`

### PHP 7.3
- `docker pull php:7.3-apache-stretch`
- `docker run --rm php:7.3-apache-stretch php --version`
- `docker build -f php/Dockerfile-7.3 -t jakubboucek/lamp-devstack-php:7.3 php/`
- `docker build -f php/Dockerfile-7.3-debug -t jakubboucek/lamp-devstack-php:7.3-debug php/`
- `docker run --rm jakubboucek/lamp-devstack-php:7.3 php --version`
- `docker run --rm jakubboucek/lamp-devstack-php:7.3-debug php --version`
- `docker tag jakubboucek/lamp-devstack-php:7.3 jakubboucek/lamp-devstack-php:7.3.x`
- `docker tag jakubboucek/lamp-devstack-php:7.3-debug jakubboucek/lamp-devstack-php:7.3.x-debug`
- `docker push jakubboucek/lamp-devstack-php:7.3`
- `docker push jakubboucek/lamp-devstack-php:7.3.x`
- `docker push jakubboucek/lamp-devstack-php:7.3-debug`
- `docker push jakubboucek/lamp-devstack-php:7.3.x-debug`

### MariaDB
- `docker pull mariadb:10.4`
- `docker run --rm mariadb:10.4 mysql --version`
- `docker build -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql:latest mysql/`
- `docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10`
- `docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4`
- `docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4.x`
- `docker push jakubboucek/lamp-devstack-mysql:latest`
- `docker push jakubboucek/lamp-devstack-mysql:10`
- `docker push jakubboucek/lamp-devstack-mysql:10.4`
- `docker push jakubboucek/lamp-devstack-mysql:10.4.x`
