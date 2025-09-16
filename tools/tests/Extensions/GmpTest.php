<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('gmp')) {
    Environment::skip('Extension gmp is not loaded');
}

$gmp = gmp_init('12345');
Assert::type('GMP', $gmp);

$result = gmp_add('10', '20');
Assert::type('GMP', $result);
Assert::same('30', gmp_strval($result));

$result = gmp_mul('5', '6');
Assert::same('30', gmp_strval($result));

$result = gmp_pow('2', 3);
Assert::same('8', gmp_strval($result));
