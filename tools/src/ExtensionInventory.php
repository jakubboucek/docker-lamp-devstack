<?php

declare(strict_types=1);

namespace Devstack;

use InvalidArgumentException;

final class ExtensionInventory
{
    private array $config;

    public function __construct(mixed $config)
    {
        self::keys($config, ['common', 'rules', 'exceptions'], 'configuration');
        self::extensions($config['common'] ?? null, 'common');
        if (!is_array($config['rules'] ?? null) || !array_is_list($config['rules'])) {
            throw new InvalidArgumentException('rules must be a list');
        }
        foreach ($config['rules'] as $i => $rule) {
            self::keys($rule, ['when', 'add', 'remove'], "rules.$i");
            self::condition($rule['when'] ?? null, "rules.$i.when");
            self::changes($rule, "rules.$i");
        }
        if (!is_array($config['exceptions'] ?? null)) {
            throw new InvalidArgumentException('exceptions must be a map');
        }
        foreach ($config['exceptions'] as $profile => $exception) {
            if (!is_string($profile) || !preg_match('~^\d+\.\d+(?:-rc)?(?:-(?:debug|cli))?$~D', $profile)) {
                throw new InvalidArgumentException('Exception keys must be exact minor profiles, e.g. 8.6-rc-debug');
            }
            self::keys($exception, ['add', 'remove', 'reason', 'removeWhen'], "exceptions.$profile");
            self::changes($exception, "exceptions.$profile");
            foreach (['reason', 'removeWhen'] as $key) {
                if (!is_string($exception[$key] ?? null) || trim($exception[$key]) === '') {
                    throw new InvalidArgumentException("exceptions.$profile.$key must explain the exception");
                }
            }
        }
        $this->config = $config;
    }

    /** Resolve image identity independently of its loaded extensions and PHP_SAPI. */
    public static function context(string $image, string $phpVersion): array
    {
        if (!preg_match('~^(\d+)\.(\d+)\.\d+(.*)$~D', $phpVersion, $runtime)) {
            throw new InvalidArgumentException('Invalid PHP runtime version');
        }
        $minor = $runtime[1] . '.' . $runtime[2];
        $rc = $runtime[3] !== '';
        if (!preg_match('~^[^\s@]+:([^/:]+)$~D', $image, $reference)) {
            throw new InvalidArgumentException('DEVSTACK_IMAGE must contain the full image reference with a tag');
        }
        $tag = $reference[1];
        if (preg_match('~^(\d+)(?:\.(\d+)(?:\.\d+)?)?(?:(-rc)(?:-(?:alpha|beta|RC)\d+)?)?(?:-(debug|cli))?$~D', $tag, $parts)) {
            if ($parts[1] !== $runtime[1] || (isset($parts[2]) && $parts[2] !== '' && $parts[2] !== $runtime[2])) {
                throw new InvalidArgumentException("Image tag $tag does not match PHP $phpVersion");
            }
            if (($parts[3] ?? '') !== ($rc ? '-rc' : '')) {
                throw new InvalidArgumentException("Image tag $tag does not match PHP pre-release status $phpVersion");
            }
            $variant = ($parts[4] ?? '') ?: 'base';
        } elseif (in_array($tag, ['latest', 'debug', 'cli'], true)) {
            $variant = $tag === 'latest' ? 'base' : $tag;
        } else {
            throw new InvalidArgumentException("Unsupported image tag $tag; use a version tag with optional -rc and -debug/-cli");
        }
        $flags = [$variant];
        if ($rc) {
            $flags[] = 'rc';
        }
        return [
            'version' => $minor,
            'flags' => $flags,
            'profile' => $minor . ($rc ? '-rc' : '') . ($variant === 'base' ? '' : '-' . $variant),
        ];
    }

    public function expected(array $context): array
    {
        $add = $remove = [];
        foreach ($this->config['rules'] as $rule) {
            if (self::matches($rule['when'], $context)) {
                $add = array_merge($add, self::extensions($rule['add'] ?? [], 'add'));
                $remove = array_merge($remove, self::extensions($rule['remove'] ?? [], 'remove'));
            }
        }
        $conflicts = array_intersect($add, $remove);
        if ($conflicts) {
            throw new InvalidArgumentException('Conflicting matching rules: ' . implode(', ', array_unique($conflicts)));
        }
        $expected = array_diff(array_merge(self::extensions($this->config['common'], 'common'), $add), $remove);
        $exception = $this->config['exceptions'][$context['profile']] ?? [];
        $expected = array_diff(
            array_merge($expected, self::extensions($exception['add'] ?? [], 'add')),
            self::extensions($exception['remove'] ?? [], 'remove'),
        );
        $expected = array_values(array_unique($expected));
        sort($expected);
        return $expected;
    }

    public function difference(array $context, array $loaded): array
    {
        $expected = $this->expected($context);
        $actual = array_map('strtolower', $loaded);
        $missing = array_values(array_diff($expected, $actual));
        $unexpected = array_values(array_unique(array_diff($actual, $expected)));
        sort($unexpected);
        return ['missing' => $missing, 'unexpected' => $unexpected];
    }

    private static function keys(mixed $value, array $allowed, string $path): void
    {
        if (!is_array($value) || array_diff(array_keys($value), $allowed)) {
            throw new InvalidArgumentException("$path must be a map with only: " . implode(', ', $allowed));
        }
    }

    private static function extensions(mixed $value, string $path): array
    {
        if (!is_array($value) || !array_is_list($value)) {
            throw new InvalidArgumentException("$path must be a list of extension names");
        }
        $names = [];
        foreach ($value as $name) {
            if (!is_string($name) || !preg_match('~^[a-zA-Z][a-zA-Z0-9_ ]*$~D', $name) || trim($name) !== $name) {
                throw new InvalidArgumentException("$path contains an invalid extension name");
            }
            $names[] = strtolower($name);
        }
        if (count($names) !== count(array_unique($names))) {
            throw new InvalidArgumentException("$path contains duplicate extension names");
        }
        return $names;
    }

    private static function changes(array $value, string $path): void
    {
        if (!array_key_exists('add', $value) && !array_key_exists('remove', $value)) {
            throw new InvalidArgumentException("$path needs add or remove");
        }
        $add = self::extensions(array_key_exists('add', $value) ? $value['add'] : [], "$path.add");
        $remove = self::extensions(array_key_exists('remove', $value) ? $value['remove'] : [], "$path.remove");
        if (array_intersect($add, $remove)) {
            throw new InvalidArgumentException("$path adds and removes the same extension");
        }
    }

    private static function condition(mixed $value, string $path): void
    {
        if (is_string($value)) {
            if (!preg_match('~^(?:[+-](?:base|debug|cli|rc)|(?:>=|<=|!=|=|>|<)\d+(?:\.\d+)?)$~D', $value)) {
                throw new InvalidArgumentException("Invalid condition at $path: $value");
            }
            return;
        }
        if (!is_array($value) || !$value) {
            throw new InvalidArgumentException("$path must be a condition or a nonempty condition list");
        }
        if (!array_is_list($value)) {
            if (count($value) !== 1 || !in_array(array_key_first($value), ['all', 'any'], true)) {
                throw new InvalidArgumentException("Invalid map at $path; quote version comparisons containing =");
            }
            $key = array_key_first($value);
            $value = $value[$key];
            $path .= '.' . $key;
            if (!is_array($value) || !array_is_list($value) || !$value) {
                throw new InvalidArgumentException("$path must be a nonempty list");
            }
        }
        foreach ($value as $i => $child) {
            self::condition($child, "$path.$i");
        }
    }

    private static function matches(string|array $condition, array $context): bool
    {
        if (is_string($condition)) {
            if ($condition[0] === '+' || $condition[0] === '-') {
                return in_array(substr($condition, 1), $context['flags'], true) === ($condition[0] === '+');
            }
            preg_match('~^(>=|<=|!=|=|>|<)(\d+)(?:\.(\d+))?$~D', $condition, $parts);
            return version_compare($context['version'], $parts[2] . '.' . ($parts[3] ?? '0'), $parts[1]);
        }
        $any = array_key_exists('any', $condition);
        $children = $condition['any'] ?? $condition['all'] ?? $condition;
        foreach ($children as $child) {
            $match = self::matches($child, $context);
            if ($any && $match) {
                return true;
            }
            if (!$any && !$match) {
                return false;
            }
        }
        return !$any;
    }
}
