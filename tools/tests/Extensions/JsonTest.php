<?php
/** @noinspection PhpComposerExtensionStubsInspection */
/** @noinspection JsonEncodingApiUsageInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('json')) {
    Environment::skip('Extension json is not loaded');
}

$data = ['test' => 'value', 'number' => 42];
$json = json_encode($data);
Assert::type('string', $json);

$decoded = json_decode($json, true);
Assert::same($data, $decoded);

Assert::same(JSON_ERROR_NONE, json_last_error());
