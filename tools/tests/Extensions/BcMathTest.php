<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('bcmath')) {
    Environment::skip('Extension bcmath is not loaded.');
}

Assert::same('3', bcadd('1', '2'));

$prev = bcscale(2);
try {
    Assert::same('0.50', bcdiv('1', '2'));
} finally {
    bcscale($prev);
}
