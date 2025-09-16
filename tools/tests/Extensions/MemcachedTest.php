<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('memcached')) {
    Environment::skip('Extension memcached is not loaded');
}

$memcached = new Memcached();
Assert::type('Memcached', $memcached);

Assert::type('int', Memcached::OPT_COMPRESSION);
Assert::type('int', Memcached::RES_SUCCESS);

$option = $memcached->getOption(Memcached::OPT_COMPRESSION);
Assert::type('bool', $option);

$version = $memcached->getVersion();
Assert::type('bool', $version);
