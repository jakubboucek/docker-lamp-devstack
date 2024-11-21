# LAMP devstack Docker images
Images for local development in [LAMP devstack](https://en.wikipedia.org/wiki/LAMP_(software_bundle))

* [Built images](#built-images)
* [Main features](#main-features)
* [Basic usage](#basic-usage)
    + [Version tags](#version-tags)
    + [Using MySQL](#using-mysql)
    + [Windows issue](#windows-issue)
* [Extended configuration](#extended-configuration)
    + [PHP configuration](#php-configuration) 
    + [Document Root](#document-root)
    + [Timezone](#timezone)
    + [Temporary, upload and session storage directory](#temporary-upload-and-session-storage-directory)
    + [Apache – listening port](#apache--listening-port)
    + [Other PHP configurations](#other-php-configurations)
* [Advanced usage](#advanced-usage)
    + [Xdebug](#xdebug)
    + [Debugging CLI with PhpStorm](#debugging-cli-with-phpstorm)
* [Building notes](#building-notes)


## Built images

- PHP: [`jakubboucek/lamp-devstack-php`](https://hub.docker.com/r/jakubboucek/lamp-devstack-php)
- MySQL: [`jakubboucek/lamp-devstack-mysql`](https://hub.docker.com/r/jakubboucek/lamp-devstack-mysql)

## Main features
- architecture: `linux/amd64`
- current **PHP** versions: 8.3, 8.2 and 8.1 and RC pre-release of 8.4
- unsupported **PHP** versions also available: 8.0, 7.4, 7.3, 7.2, 7.1, 7.0, 5.6, 5.5 and 5.4 (with limited stability,
unoptimized, unmaintained)
- current versions of **MariaDB** 11.5, 11.4, 11.2, 10.11, 10.6, 10.5, and RC pre-release of 11.6
- unsupported versions of **MariaDB** 11.3, 11.1, 11.0, 10.10, 10.9, 10.8, 10.7, 10.4 and 10.3 (unmaintained)
- current version of **Apache** 2.4 (in non-CLI images)
- current version of **Xdebug** 3.3
- extra PHP extensions:
    [`bmath`](https://www.php.net/manual/en/book.bc.php),
    [`bz2`](https://www.php.net/manual/en/book.bzip2.php),
    [`calendar`](https://www.php.net/manual/en/book.calendar.php),
    [`exif`](https://www.php.net/manual/en/book.exif.php),
    [`gd`](https://www.php.net/manual/en/book.image.php) with PNG, WebP, AVIF (for PHP 8.1+), FreeType fonts support
    [`gettext`](https://www.php.net/manual/en/book.gettext.php),
    [`gmp`](https://www.php.net/manual/en/book.gmp.php),
    [`imap`](https://www.php.net/manual/en/book.imap.php) (up to PHP 8.3),
    [`intl`](https://www.php.net/manual/en/book.intl.php),
    [`memcached`](https://www.php.net/manual/en/book.memcached.php),
    [`mysqli`](https://www.php.net/manual/en/book.mysqli.php),
    [`pdo_mysql`](https://www.php.net/manual/en/book.pdo.php),
    [`opcache`](https://www.php.net/manual/en/book.opcache.php),
    [`pcntl`](https://www.php.net/manual/en/book.pcntl.php),
    [`semaphore`](https://www.php.net/manual/en/book.sem.php),
    [`sockets`](https://www.php.net/manual/en/book.sockets.php),
    [`soap`](https://www.php.net/manual/en/book.soap.php),
    [`sodium`](https://www.php.net/manual/en/book.sodium.php),
    [`xsl`](https://www.php.net/manual/en/book.xsl.php) and
    [`zip`](https://www.php.net/manual/en/book.zip.php)
- Apache modules: [`expires`](https://httpd.apache.org/docs/current/mod/mod_expires.html),
    [`headers`](https://httpd.apache.org/docs/current/mod/mod_headers.html) and
    [`rewrite`](https://httpd.apache.org/docs/current/mod/mod_rewrite.html)
- Apache `DocumentRoot` changed to: `/var/www/html/www` (configurable by [ENV](#document-root))
- PHP image comes with [Composer 2.7+](https://getcomposer.org/) and [Git 2.39+](https://git-scm.com/) to 
    use it in guest shell  
- MySQL properly configured to use `utf8mb4` as a default charset, an optional support of Windows Host is also available
- timezones are correctly supported
- optimized for small image size and short load times


## Basic usage
Copy the [`docker-compose.yml`](docker-compose.yml) file
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose.yml&file=docker-compose.yml))
to your project's root (you don't need to clone/download the whole repo, just copy that one file).

Call `docker compose up`. After docker container runs, your project will be served at http://localhost:8080/.

Only `/www` subdirectory from your project is served but PHP scripts have access to the whole project's root.  
That means only the `/www` subdirectory is publicly accessible from web, not your whole application.

Example:
```
my_project/                 <-- project's root
    docker-compose.yml      <-- docker config from this repository
    www/                    <-- Document Root, accessible at http://localhost:8080/
        index.php           <-- your PHP app
        logo.png            <-- accessible at http://localhost:8080/logo.png
        gallery/
            photo1.jpg      <-- accessible at http://localhost:8080/gallery/photo1.jpg
    vendor/
        autoload.php        <-- not accessible but PHP can via: require(__DIR__ . '/../vendor/autoload.php')
```

### Version tags

Images are tagged by the cascaded SemVer:
- `jakubboucek/lamp-devstack-php:latest` – means `latest` available stable PHP image,
- `jakubboucek/lamp-devstack-php:8` – represents the highest PHP image of `8` version, but lower than `9.0.0`,
- `jakubboucek/lamp-devstack-php:8.3` – represents the highest PHP image of `8.3` version, but lower than `8.4.0`,
- `jakubboucek/lamp-devstack-php:8.3.0` – represents most specific PHP image, directly version `8.3.0`.

**Legacy PHP** images are tagged using different strategy, only latest revision for each minor version is available,
use `-legacy` tag suffix:

- `jakubboucek/lamp-devstack-php:8.0-legacy`
- `jakubboucek/lamp-devstack-php:7.4-legacy`
- `jakubboucek/lamp-devstack-php:7.3-legacy`
- `jakubboucek/lamp-devstack-php:7.2-legacy`
- `jakubboucek/lamp-devstack-php:7.1-legacy`
- `jakubboucek/lamp-devstack-php:7.0-legacy`
- `jakubboucek/lamp-devstack-php:5.6-legacy`
- `jakubboucek/lamp-devstack-php:5.5-legacy`
- `jakubboucek/lamp-devstack-php:5.4-legacy-fixed`

> Note: Version 5.4 is using `-fixed` suffix because is unable to rebuild them from scratch. 

All PHP images have alternative variants with XDebug extension preinstalled, use `-debug` tag suffix, example:
- `jakubboucek/lamp-devstack-php:debug`
- `jakubboucek/lamp-devstack-php:8-debug`
- `jakubboucek/lamp-devstack-php:8.3-debug`
- `jakubboucek/lamp-devstack-php:8.3.0-debug`
- `jakubboucek/lamp-devstack-php:8.4.0-rc-cli`
- `jakubboucek/lamp-devstack-php:7.4-legacy-debug`

>  Note: (Pre-release of PHP 8.4 contains unstable version of Xdebug)

All PHP images also have alternative CLI variants, use `-cli` tag suffix, example:
- `jakubboucek/lamp-devstack-php:cli`
- `jakubboucek/lamp-devstack-php:8-cli`
- `jakubboucek/lamp-devstack-php:8.3-cli`
- `jakubboucek/lamp-devstack-php:8.3.0-cli`
- `jakubboucek/lamp-devstack-php:7.4-legacy-cli`

The RC pre-release of PHP 8.4 images have the `-rc` suffix, example:
- `jakubboucek/lamp-devstack-php:8.4-rc`
- `jakubboucek/lamp-devstack-php:8.4-0-rc`
- `jakubboucek/lamp-devstack-php:8.4-0-rc-RC2`
- `jakubboucek/lamp-devstack-php:8.4-rc-cli`
- `jakubboucek/lamp-devstack-php:8.4-0-rc-cli`
- `jakubboucek/lamp-devstack-php:8.4-0-rc-RC2-cli`

### Using MySQL
MySQL server starts at the same time as the web server.

Available MySQL images:

- 10.5: `jakubboucek/lamp-devstack-mysql:10.5`
- 10.6: `jakubboucek/lamp-devstack-mysql:10.6`
- 10.11: `jakubboucek/lamp-devstack-mysql:10.11`
- 11.1: `jakubboucek/lamp-devstack-mysql:11.1`
- 11.2: `jakubboucek/lamp-devstack-mysql:11.2`
- 11.4: `jakubboucek/lamp-devstack-mysql:11.4`
- 11.5: `jakubboucek/lamp-devstack-mysql:latest`

LTS (long-term support) MySQL images (currently 11.4):

- `jakubboucek/lamp-devstack-mysql:lts`

The RC pre-release of MySQL 11.6 images have the `-rc` suffix, example:
- `jakubboucek/lamp-devstack-mysql:11.6-rc`
- `jakubboucek/lamp-devstack-mysql:11.6-1-rc`

Default credentials:
- user: `root`
- password: `devstack`
- database name: `default`

From Host, MySQL is accessible using:
- host: `127.0.0.1`
- port: `33060`

From docker guest, MySQL is accessible using:
- host: `mysqldb`
- port: `3306`

If you are connecting to the MySQL server from a PHP application running inside Docker, use the docker guest access
values, but when you're connecting from outside (for example, from your computer, using
[HeidiSQL](https://www.heidisql.com/) or [Sequel](https://sequel-ace.com/)), use host access.

PHP example:
```php
$pdo = new PDO('mysql:host=mysqldb;dbname=default;charset=utf8mb4', 'root', 'devstack');
// or
$mysqli = new mysqli('mysqldb', 'root', 'devstack', 'default');
$mysqli->set_charset('utf8mb4');
```

### Windows issue

MySQL may crash when Host is running Windows:

```
The Auto-extending innodb_system data file './ibdata1' is of a different size 0 pages than specified in the .cnf file
```

You can try to fix it by adding [`mysql-windows.cnf`](mysql/mysql-windows.cnf)
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/mysql/mysql-windows.cnf))
and add it to the MySQL config directory `/etc/mysql/conf.d/` inside the Docker container.

In `docker-compose.yml` file, just link this downloaded file to `volume` section:

```yaml
volumes:
    - "./.docker/mysql/data:/var/lib/mysql"
    - "./mysql-windows.cnf:/etc/mysql/conf.d/mysql-windows.cnf"
```

## Extended configuration

### PHP configuration 

Certain [`php.ini` directives](https://www.php.net/manual/en/ini.list.php) can be modified without manipulating the
image content, using environment variables. It can be defined in `docker run` command or in
`docker-compose.yml` file.

Configurable directives:

- `PHP_ERROR_REPORTING` - change the [`error_reporting` directive](https://www.php.net/manual/en/errorfunc.configuration.php#ini.error-reporting) (default value: `32767`, means `E_ALL`)
- `PHP_DISPLAY_ERRORS` - change the [`display_errors` directive](https://www.php.net/manual/en/errorfunc.configuration.php#ini.display-errors) (default value: `1`)
- `PHP_DISPLAY_STARTUP_ERRORS` - change the [`display_startup_errors` directive](https://www.php.net/manual/en/errorfunc.configuration.php#ini.display-startup-errors) (default value: `1`, on PHP 7: `0`)
- `PHP_ERROR_LOG` – change the [`error_log` directive](https://www.php.net/manual/en/errorfunc.configuration.php#ini.error-log) (default value: *empty*)
- `PHP_LOG_ERRORS` – change the [`log_errors` directive](https://www.php.net/manual/en/errorfunc.configuration.php#ini.log-errors) (default value: `0`)
- `PHP_MAX_EXECUTION_TIME` – change the [`max_execution_time` directive](https://www.php.net/manual/en/info.configuration.php#ini.max-execution-time) (default value: `30`)
- `PHP_MEMORY_LIMIT` – change the [`memory_limit` directive](https://www.php.net/manual/en/ini.core.php#ini.memory-limit) (default value: `2G`)
- `PHP_SESSION_SAVE_PATH` – change the [`session.save_path` directive](https://www.php.net/manual/en/session.configuration.php#ini.session.save-path) (default value: *empty*)
- `PHP_OPCACHE_BLACKLIST_FILENAME` – change the [`opcache.blacklist_filename` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.blacklist-filename) (default value: *empty*)
- `PHP_OPCACHE_ENABLE` – change the [`opcache.enable` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.enable) (default value: `1`)
- `PHP_OPCACHE_ENABLE_CLI` – change the [`opcache.enable_cli` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.enable-cli) (default value: `0`)
- `PHP_OPCACHE_JIT` – change the [`opcache.jit` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.jit) (default value: `tracing`, on PHP 8.4 [changed](https://php.watch/versions/8.4/opcache-jit-ini-default-changes): `disable`)
- `PHP_OPCACHE_JIT_BUFFER_SIZE` – change the [`opcache.jit_buffer_size` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.jit-buffer-size) (default value: `0`, on PHP 8.4 [changed](https://php.watch/versions/8.4/opcache-jit-ini-default-changes): `64M`)
- `PHP_OPCACHE_MEMORY_CONSUPTION` – change the [`opcache.memory_consumption` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.memory-consumption) (default value: `128`)
- `PHP_OPCACHE_PRELOAD` – change the [`opcache.preload` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.preload) (default value: *empty*)
- `PHP_OPCACHE_PRELOAD_USER` – change the [`opcache.preload_user` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.preload-user) (default value: *empty*)
- `PHP_OPCACHE_VALIDATE_TIMESTAMPS` – change the [`opcache.validate_timestamps` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.validate-timestamps) (default value: `1`)
- `PHP_OPCACHE_REVALIDATE_FREQ` – change the [`opcache.revalidate_freq` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.revalidate-freq) (default value: `2`)

Example for `docker run` command:

```shell
docker run --rm -e PHP_MEMORY_LIMIT=1G jakubboucek/lamp-devstack-php php -i
```

Example `docker-compose.yml` file:

```yaml
environment:
    PHP_MEMORY_LIMIT: 1G
```

### Document Root

Create custom `APACHE_DOCUMENT_ROOT` environment variable with the path to Document Root as the value.

You can also specify it directly with `docker run`:

```shell
docker run -it --rm -e APACHE_DOCUMENT_ROOT=/my-web jakubboucek/lamp-devstack-php
```

You can also put it to your `docker-compose.yml` file:

```yaml
environment:
    APACHE_DOCUMENT_ROOT: "/my-web"
```

### Timezone

The default timezone is not defined (`UTC` will be used). You can modify the default timezone by setting the `TZ`
environment variable to the desired timezone name (e.g., `Europe/Prague`).

It can also be specified directly with `docker run`:

```shell
docker run -it --rm -e TZ=Europe/Prague jakubboucek/lamp-devstack-php
```

Or in your `docker-compose.yml` file:

```yaml
environment:
    TZ: Europe/Prague
```

The `TZ` environment variable is recognized by Linux tools as well. By creating the variable you modify the default
timezone for the whole Linux operating system, PHP, and also MySQL.

At PHP since version 8.2 is `TZ` variable set to `'UTC'` by default (otherwise is empty). 

### Temporary, upload and session storage directory

PHP is using native Linux temporary directory for all own temporary files (including session and upload storage). This
image does not provide any custom way to modify them. You can use the `TEMPDIR` environment variable to modify all of
them.

You can specify it directly with `docker run`:

```shell
docker run -it --rm -e TEMPDIR=/var/www/temp jakubboucek/lamp-devstack-php
```

Or in the `docker-compose.yml` file:

```yaml
environment:
  TEMPDIR: /var/www/temp
```

Note: The directory MUST already exists and MUST be writable for all users (`0777`), otherwise PHP can be unstable or
can lose data (e.g. sessions data). Moving the temporary directory to a volume shared with the Host can have a big
impact on performance.

The `TEMPDIR` environment variable is also recognized by Linux tools. By setting that variable you modify the default
temporary directory for the whole Linux operating system, PHP, and also MySQL.

### Apache – listening port

Apache is by default configured to listening on TCP port 80. You can use the `PORT` environment variable to modify
port number where is apache listening to HTTP Requests.

Note: This variable is affect Apache runtime only. When you change port value, don't forget manually publish that port
to host, when you want to access it from here or expose port to use at network.

You can specify it directly with `docker run`:

```shell
docker run -it --rm -e PORT=8080 -p 8080:8080 jakubboucek/lamp-devstack-php
```

Or in the `docker-compose.yml` file:

```yaml
ports:
  - "8080:8080"
environment:
  PORT: 8080
```

The `PORT` environment variable is also used by most known services
(e.g. [Google Cloud Run](https://cloud.google.com/run/docs/container-contract#port)).

### Other PHP configurations

Settings other than those listed above can be set in your INI file. You can add it to `/usr/local/etc/php/conf.d`
directory using [Volume mounting](https://docs.docker.com/storage/volumes/#choose-the--v-or---mount-flag)
without building a custom image.

Create `custom.ini` file in your project's root, for example:

```ini
sendmail_from = any@my-domain.tld
```

Mount the file to the container using the `volume` directive in your `docker-compose.yml` file:

```yaml
volumes:
  - "./custom.ini:/usr/local/etc/php/conf.d/custom.ini"
```

Check available [`docker-compose.yml`](docker-compose.yml) file for an example of how to use the `volume` directive.

## Advanced usage

### Xdebug

I've also prepared a PHP image with Xdebug. Use [`docker-compose-debug.yml`](docker-compose-debug.yml)
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose-debug.yml&file=docker-compose.yml))
instead (copy and rename it to `docker-compose.yml`).

Xdebug is not started by default, you must call requests with [relevant trigger](https://xdebug.org/docs/all_settings#start_with_request#trigger)
(tip: [how to fire triggers from your browser](https://www.jetbrains.com/help/phpstorm/2021.1/browser-debugging-extensions.html)).

These features are enabled in Xdebug:

- [`Profiler`](https://xdebug.org/docs/profiler)
- [`Step Debugger`](https://xdebug.org/docs/step_debug)
- [`Tracing`](https://xdebug.org/docs/trace)

Profiler a Tracing outputs are saved to `/var/www/html/log` directory inside Container. Output files are
propagated to the Host to `log/` directory (this directory must be manually created first).

You can change the output directory through `XDEBUG_CONFIG` environment variable  with `output_dir` parameter.

In [`docker-compose.yml`](docker-compose-debug.yml) file modify the `environment` section, for example:

```yaml
environment:
    XDEBUG_CONFIG: "client_host=host.docker.internal output_dir=/another/dir"
    #                                                ^^^^^^^^^^^^^^^^^^^^^^^
```

Starting with Xdebug 3.3, Profiler a Tracing outputs are compressed with GZip. You can turn off GZip compression through
the `XDEBUG_CONFIG` environment variable with `use_compression` parameter and value `false`.

In [`docker-compose.yml`](docker-compose-debug.yml) file modify `environment` section, for example:

```yaml
environment:
    XDEBUG_CONFIG: "client_host=host.docker.internal use_compression=false"
    #                                                ^^^^^^^^^^^^^^^^^^^^^
```

### Debugging CLI with PhpStorm

With PhpStorm, you can also debug CLI scripts. First, you need to set the Server name,
[PhpStorm requires it for path mapping](https://blog.jetbrains.com/phpstorm/2012/03/new-in-4-0-easier-debugging-of-remote-php-command-line-scripts/).

In [`docker-compose.yml`](docker-compose-debug.yml) file, add `PHP_IDE_CONFIG` environment variable with `serverName`
parameter:

```yaml
environment:
    PHP_IDE_CONFIG: "serverName=docker-cli"
```

## Building notes
If you need to build custom images based on this repo, see [Build notes](build-notes.md)
