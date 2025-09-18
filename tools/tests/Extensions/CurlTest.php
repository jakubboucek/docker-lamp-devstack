<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('curl')) {
    Environment::skip('Extension curl is not loaded');
}

$ch = curl_init();
Assert::type('CurlHandle', $ch);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 5);

$version = curl_version();
Assert::type('array', $version);
Assert::true(isset($version['version']));
