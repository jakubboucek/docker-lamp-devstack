<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('pdo_mysql')) {
    Environment::skip('Extension pdo_mysql is not loaded');
}

$drivers = PDO::getAvailableDrivers();
Assert::true(in_array('mysql', $drivers, true));

Assert::type('int', PDO::MYSQL_ATTR_INIT_COMMAND);
Assert::type('int', PDO::MYSQL_ATTR_USE_BUFFERED_QUERY);

$dsn = 'mysql:host=localhost;dbname=test';
try {
    new PDO($dsn, 'invalid_user', 'invalid_pass');
} catch (PDOException $e) {
    Assert::type('string', $e->getMessage());
}
