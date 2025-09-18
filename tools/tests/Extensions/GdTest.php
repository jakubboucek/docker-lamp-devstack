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

unset($image);

$testImageFile = __DIR__ . '/assets/lorem-picsum-40.jpg';

if (!file_exists($testImageFile)) {
    throw new LogicException("Testing file not found: '{$testImageFile}'.");
}

$originalImage = imagecreatefromjpeg($testImageFile);
Assert::type('GdImage', $originalImage);

$originalWidth = imagesx($originalImage);
$originalHeight = imagesy($originalImage);
Assert::type('int', $originalWidth);
Assert::type('int', $originalHeight);
Assert::true($originalWidth > 0);
Assert::true($originalHeight > 0);

// Test image formats
$newJpgFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.jpg';
$result = imagejpeg($originalImage, $newJpgFile, 90);
Assert::true($result);
Assert::true(file_exists($newJpgFile));

$newJpegImage = imagecreatefromjpeg($newJpgFile);
Assert::type('GdImage', $newJpegImage);
Assert::same($originalWidth, imagesx($newJpegImage));
Assert::same($originalHeight, imagesy($newJpegImage));

unset($newJpegImage);
unlink($newJpgFile);

if (!$info['PNG Support']) {
    throw new RuntimeException('GD library does not support required PNG format.');
}

$pngFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.png';
$result = imagepng($originalImage, $pngFile);
Assert::true($result);
Assert::true(file_exists($pngFile));

$pngImage = imagecreatefrompng($pngFile);
Assert::type('GdImage', $pngImage);
Assert::same($originalWidth, imagesx($pngImage));
Assert::same($originalHeight, imagesy($pngImage));

unset($pngImage);
unlink($pngFile);

if (!$info['WebP Support']) {
    throw new RuntimeException('GD library does not support required WebP format.');
}
$webpFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.webp';
$result = imagewebp($originalImage, $webpFile);
Assert::true($result);
Assert::true(file_exists($webpFile));

$webpImage = imagecreatefromwebp($webpFile);
Assert::type('GdImage', $webpImage);
Assert::same($originalWidth, imagesx($webpImage));
Assert::same($originalHeight, imagesy($webpImage));

unset($webpImage);
unlink($webpFile);

if (!$info['AVIF Support']) {
    throw new RuntimeException('GD library does not support required AVIF format.');
}
$avifFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.avif';
$result = imageavif($originalImage, $avifFile);
Assert::true($result);
Assert::true(file_exists($avifFile));

$avifImage = imagecreatefromavif($avifFile);
Assert::type('GdImage', $avifImage);
Assert::same($originalWidth, imagesx($avifImage));
Assert::same($originalHeight, imagesy($avifImage));

unset($avifImage);
unlink($avifFile);

if (!$info['GIF Create Support']) {
    throw new RuntimeException('GD library does not support required GIF format.');
}
$gifFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.gif';
$result = imagegif($originalImage, $gifFile);
Assert::true($result);
Assert::true(file_exists($gifFile));

$gifImage = imagecreatefromgif($gifFile);
Assert::type('GdImage', $gifImage);
Assert::same($originalWidth, imagesx($gifImage));
Assert::same($originalHeight, imagesy($gifImage));

unset($gifImage);
unlink($gifFile);

if (!$info['BMP Support']) {
    throw new RuntimeException('GD library does not support required BMP format.');
}
$bmpFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.bmp';
$result = imagebmp($originalImage, $bmpFile);
Assert::true($result);
Assert::true(file_exists($bmpFile));

$bmpImage = imagecreatefrombmp($bmpFile);
Assert::type('GdImage', $bmpImage);
Assert::same($originalWidth, imagesx($bmpImage));
Assert::same($originalHeight, imagesy($bmpImage));

unset($bmpImage);
unlink($bmpFile);

if (!$info['WBMP Support']) {
    throw new RuntimeException('GD library does not support required WBMP format.');
}
$wbmpFile = tempnam(sys_get_temp_dir(), 'gd_test_') . '.wbmp';
// WBMP is monochrome only – create a monochrome image
$monoImage = imagecreate($originalWidth, $originalHeight);
$white = imagecolorallocate($monoImage, 255, 255, 255);
$black = imagecolorallocate($monoImage, 0, 0, 0);
imagefill($monoImage, 0, 0, $white);

$result = imagewbmp($monoImage, $wbmpFile);
Assert::true($result);
Assert::true(file_exists($wbmpFile));

$wbmpImage = imagecreatefromwbmp($wbmpFile);
Assert::type('GdImage', $wbmpImage);
Assert::same($originalWidth, imagesx($wbmpImage));
Assert::same($originalHeight, imagesy($wbmpImage));

unset($monoImage);
unset($wbmpImage);
unlink($wbmpFile);


unset($originalImage);
