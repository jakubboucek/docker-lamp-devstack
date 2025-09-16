<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('gettext')) {
    Environment::skip('Extension gettext is not loaded');
}

$result = gettext('test');
Assert::type('string', $result);

$domain = textdomain(null);
Assert::type('string', $domain);

$result = _('test');
Assert::type('string', $result);
