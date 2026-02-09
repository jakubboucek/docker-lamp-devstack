<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/bootstrap.php';

Assert::true(extension_loaded('phar'), 'Extension phar is not loaded.');

$phar = new Phar(__DIR__ . '/../../php/build/pie.phar');

Assert::match('#^\d+\.\d+\.\d+$#', $phar->getVersion(), 'Version is not in format x.y.z');
