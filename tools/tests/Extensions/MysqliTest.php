<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('mysqli')) {
    Environment::skip('Extension mysqli is not loaded');
}

$info = mysqli_get_client_info();
Assert::type('string', $info);
Assert::true(strlen($info) > 0);

$mysqli = new mysqli();
Assert::type('mysqli', $mysqli);

Assert::type('int', MYSQLI_ASSOC);
Assert::type('int', MYSQLI_NUM);
