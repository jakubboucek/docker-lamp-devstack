<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('zip')) {
    Environment::skip('Extension zip is not loaded');
}

$zip = new ZipArchive();
Assert::type('ZipArchive', $zip);

Assert::type('int', ZipArchive::CREATE);
Assert::type('int', ZipArchive::OVERWRITE);

$tmpfile = tempnam(sys_get_temp_dir(), 'zip_test_');
$result = $zip->open($tmpfile, ZipArchive::CREATE | ZipArchive::OVERWRITE);
Assert::same(true, $result);

$result = $zip->addFromString('test.txt', 'Hello World');
Assert::true($result);

$result = $zip->close();
Assert::true($result);

$zip2 = new ZipArchive();
$result = $zip2->open($tmpfile);
Assert::same(true, $result);

Assert::same(1, $zip2->numFiles);
$content = $zip2->getFromName('test.txt');
Assert::same('Hello World', $content);

$zip2->close();
unlink($tmpfile);
