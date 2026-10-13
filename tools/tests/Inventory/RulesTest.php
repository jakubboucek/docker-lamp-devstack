<?php

declare(strict_types=1);

use Devstack\ExtensionInventory;
use Nette\Neon\Neon;
use Tester\Assert;

require __DIR__ . '/../bootstrap.php';
require_once __DIR__ . '/../../src/ExtensionInventory.php';

function inventory(array $rules = [], array $exceptions = []): ExtensionInventory
{
    return new ExtensionInventory(['common' => ['Core'], 'rules' => $rules, 'exceptions' => $exceptions]);
}

function context(string $tag = '8.6-rc-debug', string $version = '8.6.0RC3'): array
{
    return ExtensionInventory::context('registry.example:5000/dev/php:' . $tag, $version);
}

$debug = context();
Assert::same(['debug', 'rc'], $debug['flags']);
Assert::same('8.6-rc-debug', $debug['profile']);
Assert::same(['base'], context('8.5', '8.5.11')['flags']);
Assert::same(['cli'], context('8-cli', '8.5.11')['flags']);
Assert::same('8.6-rc-debug', context('8.6.0-rc-RC3-debug')['profile']);
Assert::same('8.7-debug', context('debug', '8.7.0')['profile']);

$rules = [
    ['when' => ['>=8.6', ['any' => ['+debug', '+cli']]], 'add' => ['intl']],
    ['when' => ['all' => ['+debug', '-cli']], 'add' => ['Xdebug', 'SPX']],
    ['when' => ['+base'], 'remove' => ['core']],
];
$matrix = inventory($rules);
Assert::same(['core', 'intl', 'spx', 'xdebug'], $matrix->expected($debug));
Assert::same(['core', 'intl'], $matrix->expected(context('8.7-cli', '8.7.0')));
Assert::same(['core', 'intl', 'spx', 'xdebug'], $matrix->expected(context('8.7-debug', '8.7.0')));
Assert::same([], $matrix->expected(context('8.5', '8.5.11')));
Assert::same(['missing' => ['intl'], 'unexpected' => ['extra']],
    $matrix->difference($debug, ['Core', 'SPX', 'Xdebug', 'extra']));
Assert::same(['missing' => [], 'unexpected' => []],
    $matrix->difference($debug, ['Xdebug', 'SPX', 'intl', 'Core']));

foreach (['=8.4' => true, '!=8.4' => false, '>8.4' => false, '>=8.4' => true,
    '<8.4' => false, '<=8.4' => true, '<8' => false, '>8' => true] as $condition => $matches) {
    $i = inventory([['when' => [$condition], 'add' => ['intl']]]);
    Assert::same($matches ? ['core', 'intl'] : ['core'], $i->expected(context('8.4', '8.4.26')));
}
Assert::same(['core', 'intl'], inventory([['when' => ['>8.9'], 'add' => ['intl']]])
    ->expected(context('8.10', '8.10.0')));

$exception = ['8.6-rc-debug' => [
    'remove' => ['xdebug'], 'add' => ['json'],
    'reason' => 'Test fixture', 'removeWhen' => 'When the fixture ends',
]];
Assert::same(['core', 'intl', 'json', 'spx'], inventory($rules, $exception)->expected($debug));
Assert::same(['core', 'intl', 'spx', 'xdebug'], inventory($rules, $exception)
    ->expected(context('8.6-debug', '8.6.0')));
Assert::exception(fn() => inventory([
    ['when' => ['+debug'], 'add' => ['SPX']],
    ['when' => ['>=8'], 'remove' => ['spx']],
])->expected($debug), InvalidArgumentException::class, 'Conflicting matching rules: spx');

foreach (['', '8.6-rc-cli-debug', '8.6-rc-dev'] as $tag) {
    Assert::exception(fn() => context($tag), InvalidArgumentException::class);
}
Assert::exception(fn() => ExtensionInventory::context('', '8.6.0RC3'), InvalidArgumentException::class);
Assert::exception(fn() => context('8.5-debug'), InvalidArgumentException::class);
Assert::exception(fn() => context('8.6-debug'), InvalidArgumentException::class);

foreach ([[], 8.6, ['>' => 8.6], ['all' => []], ['any' => ['+debug'], 'all' => ['+cli']],
    ['any' => '+debug'], ['+debig'], ['>=8.6.0'], [1 => '+debug'], ['all' => [['wat' => ['+cli']]]]] as $bad) {
    Assert::exception(fn() => inventory([['when' => $bad, 'add' => ['intl']]]), InvalidArgumentException::class);
}
$unquoted = Neon::decode("when:\n\t- >=8.6\n\t- -cli");
Assert::exception(fn() => inventory([['when' => $unquoted['when'], 'add' => ['intl']]]),
    InvalidArgumentException::class, 'Invalid map at rules.0.when.0; quote version comparisons containing =');
foreach ([
    ['common' => ['Core', 'core'], 'rules' => [], 'exceptions' => []],
    ['common' => [], 'rules' => [], 'exceptions' => [], 'profiles' => []],
    ['common' => [], 'rules' => [['when' => ['+cli'], 'add' => null]], 'exceptions' => []],
    ['common' => [], 'rules' => [['when' => ['+cli'], 'add' => ['x'], 'remove' => ['X']]], 'exceptions' => []],
    ['common' => [], 'rules' => [], 'exceptions' => ['8.6-rc' => ['remove' => ['x']]]],
] as $bad) {
    Assert::exception(fn() => new ExtensionInventory($bad), InvalidArgumentException::class);
}
