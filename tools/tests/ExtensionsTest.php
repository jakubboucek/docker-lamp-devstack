<?php

declare(strict_types=1);

use Devstack\ExtensionInventory;
use Nette\Neon\Neon;
use Tester\Assert;

require __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/../src/ExtensionInventory.php';

$context = ExtensionInventory::context(getenv('DEVSTACK_IMAGE') ?: '', PHP_VERSION);
$inventory = new ExtensionInventory(Neon::decodeFile(__DIR__ . '/expected-extensions.neon'));
$difference = $inventory->difference($context, get_loaded_extensions());
Assert::true($difference === ['missing' => [], 'unexpected' => []],
    'PHP ' . PHP_VERSION . ', profile ' . $context['profile']
    . '; missing: ' . implode(', ', $difference['missing'])
    . '; unexpected: ' . implode(', ', $difference['unexpected']));
