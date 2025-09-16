<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('pcntl')) {
    Environment::skip('Extension pcntl is not loaded');
}

$pid = pcntl_get_last_error();
Assert::type('int', $pid);
Assert::true($pid === 0);

Assert::type('int', SIGTERM);
Assert::type('int', SIGKILL);
Assert::type('int', SIGHUP);

pcntl_signal_dispatch();

$error = pcntl_get_last_error();
Assert::type('int', $error);
