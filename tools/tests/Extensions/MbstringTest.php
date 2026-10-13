<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('mbstring')) {
    Environment::skip('Extension mbstring is not loaded');
}

$text = 'Žluťoučký kůň 🐎';
Assert::same(15, mb_strlen($text, 'UTF-8'));
Assert::same('kůň', mb_substr($text, 10, 3, 'UTF-8'));
Assert::same(10, mb_strpos($text, 'kůň', 0, 'UTF-8'));
Assert::same('ŽLUŤOUČKÝ KŮŇ 🐎', mb_strtoupper($text, 'UTF-8'));
Assert::true(mb_check_encoding($text, 'UTF-8'));
Assert::false(mb_check_encoding("\xC3\x28", 'UTF-8'));

Assert::same("\x00\x41\x01\x7D", mb_convert_encoding('AŽ', 'UTF-16BE', 'UTF-8'));
Assert::same('AŽ', mb_convert_encoding("\x00\x41\x01\x7D", 'UTF-8', 'UTF-16BE'));
