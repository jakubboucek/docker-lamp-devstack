<?php
/** @noinspection PhpComposerExtensionStubsInspection */

declare(strict_types=1);

use Tester\Assert;
use Tester\Environment;

require __DIR__ . '/../bootstrap.php';

$processor = new XSLTProcessor();
Assert::type('XSLTProcessor', $processor);

$xsl = new DOMDocument();
$xml = new DOMDocument();

$xslContent = '<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/"><html><body><xsl:value-of select="test"/></body></html></xsl:template>
</xsl:stylesheet>';

$xmlContent = '<?xml version="1.0"?><test>Hello World</test>';

Assert::true($xsl->loadXML($xslContent));
Assert::true($xml->loadXML($xmlContent));

Assert::true($processor->importStylesheet($xsl));

$result = $processor->transformToXML($xml);
Assert::type('string', $result);
Assert::contains('Hello World', $result);
