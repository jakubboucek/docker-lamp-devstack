# Building notes
Notes how to build new version of prepared images.

This note is not necessary for USE images, it's for BUILD him. 

## PHP
Run [`build-php.sh`](build-php.sh) script to build all of PHP versions.

To build only specific PHP version run only the target script on [`php` folder](php), for example:
[`php/build-php-8.5.sh`](php/build-php-8.4.sh)

To build older PHP versions run [`php/legacy/build-php-legacy.sh`](php/legacy/build-php-legacy.sh).

### PHP 8.6 RC

PHP 8.6 requires PIE 1.5 or newer ([upstream support](https://github.com/php/pie/pull/667)).
Run `./prepare-assets.sh` before rebuilding with `NO_PULL=1` if `php/build/pie.phar`
was downloaded before that release. The normal build flow downloads the latest stable PIE.

Memcached uses `dev-master` for the [PHP 8.6 API fixes](https://github.com/php-memcached-dev/php-memcached/pull/580).
The stable 3.4.0 release does not compile on PHP 8.6. Return to stable package selection
when a release containing those fixes is available.

The debug variant uses `xdebug/xdebug:^3.6@alpha` and `noisebynorthwest/php-spx:0.5.x-dev`.
Xdebug 3.6.0alpha1 supports PHP 8.6; SPX support is in the `v0.5` branch, not `master`.
Stable SPX 0.4.22 and `dev-master` still declare PHP <8.6.

The SPX build needs two compatibility flags on PHP 8.6 RC3 / Debian Trixie:
`-Wno-error=old-style-declaration` keeps a ZTS TLS declaration warning non-fatal,
and `-Dtypeof=__typeof__` allows the PHP headers' GNU type operator under SPX's strict
C11 mode. `CI=true` disables SPX's `-march=native` so the image remains portable across
amd64 CPUs. Revisit these workarounds when upstream fixes its build configuration.

The 8.6 debug Dockerfile uses the bundled Dockerfile frontend (no external `syntax` directive).
With Docker 29.8.2 / BuildKit 0.33.1 and the containerd image store, the external frontend
resolved the published base instead of the freshly built local image. The bundled frontend
used the local base correctly; the build smoke checks explicitly require memcached in the
debug image to catch this regression.

Upstream references: [Xdebug 3.6 alpha](https://xdebug.org/announcements/2026-09-08),
[SPX PHP 8.6 metadata](https://github.com/NoiseByNorthwest/php-spx/pull/349).

#### Required cleanup when PHP 8.6 becomes stable

- Remove the temporary SPX `CFLAGS` override (`-Wno-error=old-style-declaration`
  and `-Dtypeof=__typeof__`) and its explanatory comments. These are accepted only
  for the RC phase, not as permanent build configuration.
- Replace the memcached `dev-master`, Xdebug `^3.6@alpha`, and SPX `0.5.x-dev`
  selectors with compatible stable releases, then update the RC-specific documentation.
- Rebuild and verify the images without the workarounds. If upstream still requires
  any exception, explicitly discuss it with the maintainer rather than silently
  carrying it into the stable images.
- Review `CI=true` separately: it prevents CPU-specific SPX builds and must not be
  removed unless the resulting image remains portable across amd64 CPUs.

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

