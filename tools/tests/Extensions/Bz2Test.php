<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('bz2')) {
    Environment::skip('Extension bz2 is not loaded.');
}

$compressed = bzcompress('x');
Assert::type('string', $compressed);

$decompressed = bzdecompress($compressed);
Assert::same('x', $decompressed);
