<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('gd')) {
    Environment::skip('Extension gd is not loaded');
}

$info = gd_info();
Assert::type('array', $info);
Assert::true(isset($info['GD Version']));

$image = imagecreate(100, 100);
Assert::type('GdImage', $image);

$color = imagecolorallocate($image, 255, 0, 0);
Assert::type('int', $color);

imagedestroy($image);
