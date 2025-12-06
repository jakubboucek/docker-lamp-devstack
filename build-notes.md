# Building notes
Notes how to build new version of prepared images.

This note is not necessary for USE images, it's for BUILD him. 

## PHP
Run [`build-php.sh`](build-php.sh) script to build all of PHP versions.

To build only specific PHP version run only the target script on [`php` folder](php), for example:
[`php/build-php-8.5.sh`](php/build-php-8.4.sh)

To build older PHP versions run [`php/legacy/build-php-legacy.sh`](php/legacy/build-php-legacy.sh).

## MariaDB
Run [`build-mariadb.sh`](build-mariadb.sh) script to build all of MariaDB versions.

## Partion build

All of scripts above supports ENV variables to do partial build only.

- `NO_PULL=1` - Build images without pull newest version of base images from Docker Hub repository 
- `NO_BUILD=1` - Process build without `docker build` run (usefull for push pre-builded images) 
- `NO_TEST=1` - Build images without test builded images
- `NO_PUSH=1` - Build images without push them to Docker Hub repository
- `NO_ASSETS=1` - Build images without prepare assets (like downloading sources, preparing build context, etc.)

### Usage

Only build PHP images without push them to Docker Hub repository:

```shell
NO_PUSH=1 ./build-php.sh
```

Only push pre-builded PHP images to Docker Hub repository:

```shell
NO_PULL=1 NO_BUILD=1 ./build-php.sh
```

