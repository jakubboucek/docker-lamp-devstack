<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('exif')) {
    Environment::skip('Extension exif is not loaded.');
}

$pngBase64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';

$file = __DIR__ . '/assets/exif.jpg';
$type = exif_imagetype($file);
$data = exif_read_data($file);
Assert::same(IMAGETYPE_JPEG, $type);
Assert::type('array', $data );
Assert::same('ION230', $data['Model']);
