<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('intl')) {
    Environment::skip('Extension intl is not loaded');
}

$locale = Locale::getDefault();
Assert::type('string', $locale);

$formatter = new NumberFormatter('en_US', NumberFormatter::DECIMAL);
Assert::type('NumberFormatter', $formatter);

$formatted = $formatter->format(1234.5);
Assert::type('string', $formatted);

$collator = new Collator('en_US');
Assert::type('Collator', $collator);

$result = $collator->compare('apple', 'banana');
Assert::type('int', $result);
