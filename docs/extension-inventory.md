# Extension inventory declaration

`tools/tests/expected-extensions.neon` declares the expected PHP extensions for each
image profile. `tools/tests/ExtensionsTest.php` checks this declaration as part of
Nette Tester. Current build scripts invoke the suite before publishing images.

Prepare tooling with `composer -d tools install`, then use `./test-php.sh` or
`./test-php.sh 8.6-rc-debug`. Dependencies are installed on the host and mounted
read-only into containers; they are not added to published images. Composer resolves
for PHP 8.1 via `config.platform.php`. NEON 3.4.8 is pinned: its declared upper bound
is 8.5, but its runtime behavior has also been verified for this project on PHP 8.6.

The runner passes `IMAGE_NAME` with the full image reference. The test reads the
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
  has `add` and/or `remove`, a `reason`, and a human-readable `removeWhen` note for retiring it.
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

## Exceptions

An exception targets one canonical minor profile, including its variant and release
status. It has no `when`: the map key selects the profile. For example,
`8.6-rc-debug` matches all patch tags for that RC debug profile, but not `8.6-rc`,
`8.6-rc-cli`, or stable `8.6-debug`. A quoted key `'8.5'` targets only the stable
8.5 base variant. Wildcards and version expressions are not supported as keys.

Each exception needs at least one of `add` or `remove`, plus two nonempty strings:

- `reason` explains why the normal expectations do not apply.
- `removeWhen` tells the maintainer when to delete the exception. It is **human-readable
  documentation**, not an evaluated condition, date, or automatic expiration mechanism.
  Even a string such as `'>=8.7'` would only be text here. Delete the entry manually
  once its stated condition is satisfied.

The following complete miniature configuration is illustrative; it does not describe
an actual missing extension in our current images:

```neon
exceptions:
    8.6-rc-debug:
        remove: [spx]
        reason: The profiler cannot currently be built for this RC.
        removeWhen: Delete after a compatible profiler is installed and verified.

rules:
    - when: +debug
      add: [xdebug, spx]

common: [core, json]
```

The debug rule first adds both profilers. For `8.6-rc-debug`, the exception then
removes `spx`: the final expected set is `core`, `json`, `xdebug`. A loaded `spx`
would fail as unexpected, reminding the maintainer to retire the exception after
restoring it. Other debug profiles still require both profilers.

Exceptions apply last even when their section appears first in the file. An `add`
can restore an extension removed by an ordinary rule; a `remove` can exclude one
from `common` or a matching rule. A single exception cannot both add and remove the
same extension. Conflicting ordinary rules fail before exceptions are applied.
Use `exceptions: []` or `exceptions: {}` when there are no exceptions; both decode
to an empty PHP array.

## Examples

These independent snippets illustrate the rule language, not changes to the current
extension policy. When trying a snippet on its own, supply any omitted top-level
sections (`common`, `rules`, `exceptions`) with empty lists/maps.

### Version range, alternative variants, and stable releases only

```neon
rules:
    - when:
        - '>=8.4'
        - '<8.7'
        - -rc
        - any: [+debug, +cli]
      add: [intl]
```

Every outer list item must match. This adds `intl` for stable PHP 8.4, 8.5 and 8.6
in either debug or CLI variants. It excludes base variants, every pre-release,
PHP 8.3 and PHP 8.7+. All patch versions of each matching minor series are included.

### Alternatives with their own combined conditions

```neon
rules:
    - when:
        any:
            - all: ['>=8.6', +debug]
            - all: ['=8.4', +cli, -rc]
      add: [sockets]
```

This adds `sockets` if either branch matches: debug PHP 8.6 or later (including RC),
or stable CLI PHP 8.4. It does not match CLI PHP 8.6 or debug PHP 8.5. Each inner
`all` applies only to its own branch; the second branch's `-rc` does not restrict
the first branch.

### Removing a common extension, then restoring it for one exact profile

```neon
exceptions:
    8.6-rc:
        add: [intl]
        reason: This specific RC base profile retains intl for compatibility.
        removeWhen: Delete when this profile adopts the general base-image policy.

rules:
    - when: ['>=8.6', +base]
      remove: [intl]

common: [core, intl]
```

The rule removes `intl` from base PHP 8.6 and later, both stable and RC. The exception
restores it only for `8.6-rc`. Consequently, stable `8.6` and `8.7-rc` require only
`core`, while `8.6-rc` requires both extensions. CLI and debug variants also retain
both because they never match `+base`. Removing an expectation does not make the
extension optional: it must be absent unless subsequently restored by the exception.

### Accumulating matching rules without relying on their order

```neon
rules:
    - when: +debug
      add: [xdebug, spx]
    - when: ['>=8.5']
      add: [lexbor, uri]
    - when: ['>=8.6', -cli, '!=8.7']
      add: [intl]
```

For `8.6-rc-debug`, all three rules match and their additions are combined with
`common`. For `8.7-debug`, only the first two match. For `8.8-cli`, only the second
matches; `-cli` excludes it from the third. For base `8.8`, the second and third
match. None of these rules excludes RC unless `-rc` is explicitly present.

Repeated additions across matching rules are combined into one expected extension.
However, adding `remove: [spx]` to the third rule would create a conflict for
`8.6-rc-debug`, because the first rule adds `spx`. Moving either rule earlier or later
would not resolve it; use non-overlapping conditions or a justified exact exception.
