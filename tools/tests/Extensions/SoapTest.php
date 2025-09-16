<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

if (!extension_loaded('soap')) {
    Environment::skip('Extension soap is not loaded');
}

try {
    $client = new SoapClient(null, [
        'location' => 'http://localhost/soap',
        'uri' => 'http://localhost/soap',
        'soap_version' => SOAP_1_1
    ]);
    Assert::type('SoapClient', $client);
} catch (SoapFault $e) {
    Assert::type('string', $e->getMessage());
}

Assert::type('int', SOAP_1_1);
Assert::type('int', SOAP_1_2);

try {
    $server = new SoapServer(null, ['uri' => 'http://localhost/soap']);
    Assert::type('SoapServer', $server);
} catch (Exception $e) {
    Assert::type('string', $e->getMessage());
}
