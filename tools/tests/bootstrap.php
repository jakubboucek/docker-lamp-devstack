<?php
declare(strict_types=1);

require __DIR__ . '/../vendor/autoload.php';

Tester\Environment::setup();
Tester\Dumper::$dumpDir = sys_get_temp_dir() . '/devstack-test-output';
date_default_timezone_set('Europe/Prague');
