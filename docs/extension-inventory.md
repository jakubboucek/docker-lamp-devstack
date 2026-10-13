# Extension inventory declaration

`tools/tests/expected-extensions.neon` declares the expected PHP extensions for each
image profile. `tools/tests/ExtensionsTest.php` checks this declaration as part of
Nette Tester. Current build scripts invoke the suite before publishing images.

Prepare tooling with `composer -d tools install`, then use `./test-php.sh` or
`./test-php.sh 8.6-rc-debug`. Dependencies are installed on the host and mounted
read-only into containers; they are not added to published images. Composer resolves
for PHP 8.1 via `config.platform.php`. NEON 3.4.8 is pinned: its declared upper bound
is 8.5, but its runtime behavior has also been verified for this project on PHP 8.6.

The runner passes `DEVSTACK_IMAGE` with the full image reference. The test reads the
actual PHP version, derives base/CLI/debug from the tag, and checks that numeric tags
match the runtime major/minor and pre-release status. Numeric tags may include patch
versions and RC release labels; aliases `latest`, `debug`, `cli`, and major tags such
as `8-cli` also work. Exact exceptions use the canonical minor profile (e.g.
`8.6-rc-debug`), independent of the patch tag used to launch the container.

Every pre-release runtime (alpha, beta, RC or dev) receives the `rc` flag. Unknown
future PHP versions use the same rules without registration; unrecognized tag
suffixes and missing image identity are errors. The functional extension tests retain
their skips, but the inventory test never skips missing extensions.

## Structure

- `common`: extensions expected in every supported profile.
- `rules`: a list of conditions (`when`) and extension lists to `add` or `remove`.
  All matching rules apply. Conflicting additions/removals between matching rules are
  errors; rule order does not resolve conflicts.
- `exceptions`: a map keyed by exact profile, applied after ordinary rules. Each entry
  has `add` and/or `remove`, a `reason`, and a `removeWhen` condition for retiring it.
  Use `{}` when no exceptions are needed. Quote numeric-looking keys such as `'8.5'`.

Extension names are compared case-insensitively (`SPX` becomes `spx`, `Zend OPcache`
becomes `zend opcache`). Missing and unexpected extensions both fail the check;
`remove` means the extension must be absent, not optional.

## Conditions

A plain condition list means AND. Explicit `all` (AND) and `any` (OR) accept lists
of conditions and may be nested. For example, PHP 8.6 or later with debug or CLI:

```neon
when:
	- '>=8.6'
	- any: [+debug, +cli]
```

PHP 8.6 or later in any non-CLI variant:

```neon
when:
	- '>=8.6'
	- -cli
```

Version operators are `=`, `!=`, `>`, `>=`, `<`, and `<=`. They compare PHP minor
series: `=8.4` includes every 8.4.x, `>8.4` starts at 8.5, and `<8` means below 8.0.
Pre-release status is a flag and does not affect numeric version comparisons.

`+flag` requires a flag; `-flag` excludes it. Flags are `debug`, `cli`, `rc`, and
synthetic `base` (neither debug nor CLI):

| Profile | Flags |
| --- | --- |
| `8.5` | base |
| `8.5-debug` | debug |
| `8.5-cli` | cli |
| `8.6-rc` | base, rc |
| `8.6-rc-debug` | debug, rc |

Thus `-debug` also matches CLI, while `+base` includes RC base images. Unknown flags
and unsupported combinations such as CLI plus debug are errors.

Unquoted conditions are allowed when NEON parses them as strings. Operators containing
`=` require quotes because NEON otherwise interprets them as mappings or syntax errors.
Validate recursively: accept string leaves, nonempty lists with consecutive integer
keys starting at zero, and maps containing exactly one `all` or `any` key with a
nonempty condition list. Reject other maps, non-string leaves and empty logical nodes.
Never reconstruct a comparator from a parsed mapping: numeric conversion may have
already changed a version such as `8.10` to `8.1`.

The configuration validator checks every rule, including inactive rules, and rejects
unknown fields, duplicate extension names and malformed exception entries. String
conditions also work directly in `when`. An exception cannot resolve a conflict between
ordinary matching rules: fix the conflicting rules first.

A failure reports the runtime PHP version, canonical profile and sorted missing and
unexpected modules. Build scripts honor `NO_TEST=1` as an explicit bypass; otherwise
a failing suite prevents that build script from reaching its push phase. This does
not make a multi-version release atomic. The suite inspects CLI-loaded modules in
each image; HTTP/Apache behavior remains a separate concern.
