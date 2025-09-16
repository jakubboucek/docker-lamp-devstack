<?php

/** @noinspection AutoloadingIssuesInspection */
declare(strict_types=1);

/**
 * Helper script for Docker builds.
 *
 * Scans compiled PHP extensions (.so) and determines required runtime packages.
 * Purpose: replace heavy -dev build dependencies with minimal runtime libraries,
 * reducing the final Docker image size.
 *
 * Output: table of extensions → packages, plus an `apt-mark` command
 * ready to copy into a Dockerfile.
 */

use Tracy\Debugger;

require __DIR__ . '/vendor/autoload.php';

Debugger::enable(Debugger::Development);

echo "----------------------------------------------------\n";
echo "=== Computing PHP extension runtime dependencies ===\n";
echo "----------------------------------------------------\n\n";

$extDir = ini_get('extension_dir');
if (!$extDir || !is_dir($extDir)) {
    throw new RuntimeException("Invalid extension_dir: '{$extDir}'.");
}

$ignoreLibNames = ['linux-vdso.so.1', 'ld-linux-x86-64.so.2'];
$ignorePkgs = ['libc6', 'libgcc-s1', 'libgcc1', 'libc-bin', 'libstdc++6', 'multiarch-support'];

$it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($extDir, FilesystemIterator::SKIP_DOTS));
$soFiles = [];
foreach ($it as $f) {
    if ($f->isFile() && str_ends_with($f->getFilename(), '.so')) {
        $soFiles[] = $f->getPathname();
    }
}

if (!$soFiles) {
    throw new RuntimeException("No .so files found in '{$extDir}'.");
}

echo "Found " . count($soFiles) . " extensions to process.\n\n";
echo "Querying dependencies:\n";
echo "----------------------\n\n";

sort($soFiles);

$allLibs = [];    // so => [lib...]
$map = [];      // so => [pkg...]
$allPkgs = [];  // flat list

foreach ($soFiles as $so) {
    $soName = basename($so, '.so');
    echo "  Extension '{$soName}', ";

    $ldd = sh('ldd ' . escapeshellarg($so));

    $libs = parseLdd($ldd->out, $ignoreLibNames);

    if (!$libs) {
        echo "no dependency.\n\n";
    } else {
        echo count($libs) . " dependencies:\n";
    }

    $pkgs = [];
    foreach ($libs as $lib) {
        $libName = basename($lib);
        echo "    - {$libName}: ";

        if (array_key_exists($lib, $allLibs)) {
            $pkg = $allLibs[$lib];
            echo ($pkg ?? '(unknown)') . " *";
        } else {
            $pkg = queryDpkgPackage($lib);
            $allLibs[$lib] = $pkg;
            echo($pkg ?? "(unknown)");
        }

        echo "\n";

        if ($pkg) {
            $pkgs[] = $pkg;
            $allPkgs[] = $pkg;
        }
    }

    $map[$so] = array_values(array_unique($pkgs));

    echo "\n";
}

echo "\n  Note: Packages marked with * were cached from previous query.\n\n";

$allPkgs = array_values(array_unique($allPkgs));
sort($allPkgs);

echo "Extension dependencies:\n";
echo "-----------------------\n\n";

foreach ($map as $so => $pkgs) {
    echo "  - " . basename($so, '.so') . ": ";

    if (empty($pkgs)) {
        echo "(none)\n";
        continue;
    }
    echo "\n";

    foreach ($pkgs as $pkg) {
        $flag = in_array($pkg, $ignorePkgs, true) ? '(i) ' : ' +  ';
        echo "    {$flag}{$pkg}\n";
    }
}

echo "\n";
echo "Docker file snippet to mark dependency packages for APT as manually installed:\n";
echo "------------------------------------------------------------------------------\n\n";

$filter = static fn(string $p) => !in_array($p, $ignorePkgs, true);
$runtimePkgs = array_values(array_filter($allPkgs, $filter));

if (!$runtimePkgs) {
    throw new LogicException("No runtime packages detected.");
}

$dlm = " \\\n    ";
echo "ARG EXTENSION_RUNTIME_DEPS=\" {$dlm}    " . implode("$dlm    ", $runtimePkgs) . "{$dlm}\"\n\n";

echo "------------------------------------------------------------------------------\n";

class ShResponse
{
    public readonly int $code;
    public readonly string $out;
    public readonly string $err;

    public function __construct(int $code, string $out, string $err)
    {
        $this->code = $code;
        $this->out = $out;
        $this->err = $err;
    }

    public function isOk(): bool
    {
        return $this->code === 0;
    }
}

class ShException extends RuntimeException
{
    public readonly ShResponse $response;

    public function __construct(string $cmd, ShResponse $response)
    {
        parent::__construct("Command failed (code {$response->code}): '{$cmd}'\nError output:\n{$response->err}");
        $this->response = $response;
    }
}

function sh(string $cmd): ShResponse
{
    $descs = [1 => ['pipe', 'w'], 2 => ['pipe', 'w']];
    $p = proc_open($cmd, $descs, $pipes);
    if (!is_resource($p)) {
        throw new RuntimeException("Cannot run command: '{$cmd}'");
    }

    $out = stream_get_contents($pipes[1]);
    $err = stream_get_contents($pipes[2]);
    fclose($pipes[1]);
    fclose($pipes[2]);
    $code = proc_close($p);

    $response = new ShResponse($code, $out, $err);

    if (!$response->isOk()) {
        throw new ShException($cmd, $response);
    }

    return $response;
}

function parseLdd(string $ldd, array $ignoreLibNames): array
{
    $libs = [];
    foreach (preg_split('/\R/', $ldd) as $line) {
        $line = trim($line);
        if ($line === '') {
            continue;
        }

        // "libfoo.so.1 => /path/libfoo.so.1 (0x...)"
        if (preg_match('/^\S+\s+=>\s+(\/[^ ]+)\s+\(/', $line, $m)) {
            $path = $m[1];
        } // "/lib64/ld-linux-x86-64.so.2 (0x...)"
        elseif (preg_match('/^(\/[^ ]+)\s+\(/', $line, $m)) {
            $path = $m[1];
        } else {
            continue;
        }

        if ($path[0] !== '/') {
            continue;
        }

        $soname = basename($path);
        if (in_array($soname, $ignoreLibNames, true)) {
            continue;
        }

        $real = realpath($path);
        $libs[$real ?: $path] = true;
    }
    return array_keys($libs);
}

function queryDpkgPackage(string $absPath): ?string
{
    $out = trim(sh('dpkg-query -S ' . escapeshellarg($absPath) . ' | head -n1')->out);
    if ($out === '') {
        return null;
    }
    // "pkg:arch: /path" → "pkg"
    return preg_replace('/:.*/', '', $out) ?: null;
}
