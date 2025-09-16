<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('Zend OPcache')) {
    Environment::skip('Extension Zend OPcache is not loaded');
}

$config = opcache_get_configuration();
if ($config !== false) {
    Assert::type('array', $config);
    Assert::true(isset($config['version']));
}

$status = opcache_get_status(false);
if ($status !== false) {
    Assert::type('array', $status);
}

$result = opcache_is_script_cached('/nonexistent/file.php');
Assert::type('bool', $result);
