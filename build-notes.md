# Building notes
Notes how to build new version of prepared images.

This note is not necessary for USE images, it's for BUILD him. 

## PHP
Run [`build-php.sh`](build-php.sh) script to build all of PHP versions.

To build only specific PHP version run only the target script on [`php` folder](php), for example:
[`php/build-php-8.5.sh`](php/build-php-8.4.sh)

To build older PHP versions run [`php/legacy/build-php-legacy.sh`](php/legacy/build-php-legacy.sh).

### Debug image base

Current debug Dockerfiles use the bundled Dockerfile frontend (no `syntax`
directive) so the build uses the freshly built local base image.
Keep `# check=skip=SecretsUsedInArgOrEnv` as the first line to
suppress the warning for the default development SPX key (`PHP_SPX_HTTP_KEY`).

### PHP 8.6 RC

PHP 8.6 builds require PIE 1.5 or newer. When reusing assets with `NO_PULL=1`,
run `./prepare-assets.sh` first if the cached `php/build/pie.phar` is older.
Build the Apache image before debug; the debug Dockerfile uses the bundled frontend
and the locally built base. Package selectors and SPX compatibility flags are defined
and explained in the Dockerfiles. The [stable-transition checklist](https://github.com/jakubboucek/docker-lamp-devstack/issues/100)
is maintained in #100.

## MariaDB
Run [`build-mariadb.sh`](build-mariadb.sh) script to build all of MariaDB versions.

The script pulls configured minor/RC channels and reads the full release version
from the resulting image's `org.opencontainers.image.version` label. It validates
`major.minor.patch`, the expected series, and agreement with
`mariadbd --no-defaults --version` before tagging or pushing. No database is started.
Version identity validation also runs with `NO_TEST=1` when building or pushing;
`NO_TEST` skips the separate version report.

With `NO_BUILD=1`, versions come from the existing output images. Push-only runs
refresh release and alias tags from those validated images before pushing.
`NO_PULL=1` reuses local source images. With all four phases disabled, no Docker
commands run.

Major, `latest` and `lts` aliases remain explicit in the script. RC channels append
`-rc` to the detected version (for example `13.0.1-rc`); neither the label nor the
server version identifies release maturity. Switching a series to stable requires
changing its configured channel and Dockerfile.

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

