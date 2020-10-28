# LAMP devstack as Docker 
Prepared images for local development in [LAMP devstack](https://en.wikipedia.org/wiki/LAMP_(software_bundle))

## Main features
- the current version of PHP 7.3, 7.4 and 8.0 (RC)
- the current version of Apache
- added [`mod_expires`](https://httpd.apache.org/docs/current/mod/mod_expires.html)
    and [`mod_rewrite`](https://httpd.apache.org/docs/current/mod/mod_rewrite.html) modules 
- the current version of Maria 10  (with properly configured `utf8mb4` charset)
- optimized for small image size a fast load

## Basic usage
Copy the [`docker-compose.yml`](docker-compose.yml) file
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose.yml&file=docker-compose.yml))
to Your project's root (you needn't clone/download whole repo,
just copy the one file).

Call `docker-compose up`. After docker containers runs, your project will be served at http://localhost:8080/.

Served is the only directory `/www` from your project, but PHP scripts has access to whole project's root.  
That's mean, your application is no public accessible from the web, only `/www` directory.

Example:
```
my_project/                 <-- project's root
    docker-compose.yml      <-- docker config from this repository
    www/                    <-- accessible at http://localhost:8080/
        index.php           <-- your PHP app
        logo.png            <-- accessible at http://localhost:8080/logo.png
        gallery/
            photo1.jpg      <-- accessible at http://localhost:8080/gallery/photo1.jpg
    vendor/
        autoload.php        <-- not accessible from web, but PHP can: require(__DIR__ . '/../vendor/autoload.php')
```

### Using MySQL
MySQL starts at the same time as web server.

Default credentials:
- user: `root`
- password: `devstack`
- database name: `default`

From Host is MySQL accessible on: 
- host: `127.0.0.1`
- port: `33060`

From docker guest is MySQL accessible on: 
- host: `mysqldb`
- port: `3306`

That's mean, when you are connecting to MySQL from PHP application inside Docker, use the guest access, but when you
connect from outside (from Your computer, for example the [HeidiSQL](https://www.heidisql.com/)
or [Sequel](https://sequel-ace.com/)), use host access.

PHP example:
```php
$pdo = new PDO('mysql:host=mysqldb;dbname=default', 'root', 'devstack');
// or
$mysqli = new mysqli('mysqldb', 'root', 'devstack', 'default');
```

## Advanced usage
### Xdebug
Prepared is PHP with Xdebug variant too. Use [`docker-compose-debug.yml`](docker-compose-debug.yml) 
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose-debug.yml&file=docker-compose.yml))
instead (copy and rename it to `docker-compose.yml`).

Xdebug is not started by default, you must call requests with relevant trigger
([more info](https://xdebug.org/docs/remote)).

### PHP 8
Prepared is configuration to use PHP 8 (currently at Release Candidate stage).
Use [`docker-compose-debug-8.0.yml`](docker-compose-debug-8.0.yml) 
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose-debug-8.0.yml&file=docker-compose.yml))
instead (copy and rename it to `docker-compose.yml`).

PHP 8 variant contains Xdebug too.
 
## Building notes
If you need build custom images based on this repo, see [Build notes](build-notes.md)
