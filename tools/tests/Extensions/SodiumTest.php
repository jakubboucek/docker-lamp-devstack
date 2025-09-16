<?php
/** @noinspection PhpComposerExtensionStubsInspection */
/** @noinspection PhpUnhandledExceptionInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('sodium')) {
    Environment::skip('Extension sodium is not loaded');
}

$hash = sodium_crypto_generichash('test message');
Assert::type('string', $hash);
Assert::same(SODIUM_CRYPTO_GENERICHASH_BYTES, strlen($hash));

//$random = \Sodium\randombytes_buf(32);
//Assert::type('string', $random);
//Assert::same(32, strlen($random));

Assert::type('int', SODIUM_CRYPTO_GENERICHASH_BYTES);
Assert::type('int', SODIUM_CRYPTO_SECRETBOX_KEYBYTES);

$keypair = sodium_crypto_box_keypair();
Assert::type('string', $keypair);
Assert::same(SODIUM_CRYPTO_BOX_KEYPAIRBYTES, strlen($keypair));
