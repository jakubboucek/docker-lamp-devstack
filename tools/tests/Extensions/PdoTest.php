<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('pdo')) {
    Environment::skip('Extension pdo is not loaded');
}

$drivers = PDO::getAvailableDrivers();
Assert::type('array', $drivers);

Assert::type('int', PDO::FETCH_ASSOC);
Assert::type('int', PDO::ATTR_ERRMODE);

try {
    $pdo = new PDO('sqlite::memory:');
    Assert::type('PDO', $pdo);

    $result = $pdo->query('SELECT 1 as test');
    Assert::type('PDOStatement', $result);

    $row = $result->fetch(PDO::FETCH_ASSOC);
    Assert::same(['test' => 1], $row);
} catch (PDOException $e) {
    Environment::skip('SQLite not available for PDO test');
}
