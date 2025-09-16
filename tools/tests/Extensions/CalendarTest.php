<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('calendar')) {
    Environment::skip('Extension calendar is not loaded.');
}

Assert::same(29, cal_days_in_month(CAL_GREGORIAN, 2, 2024));

$info = cal_info(CAL_GREGORIAN);
Assert::type('array', $info);
Assert::true(isset($info['months']) && count($info['months']) === 12);
