<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('sockets')) {
    Environment::skip('Extension sockets is not loaded');
}

$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
if ($socket !== false) {
    Assert::type('Socket', $socket);
    socket_close($socket);
}

Assert::type('int', AF_INET);
Assert::type('int', SOCK_STREAM);
Assert::type('int', SOL_TCP);

$error = socket_strerror(1);
Assert::type('string', $error);
