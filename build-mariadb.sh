#!/bin/bash

set -eux

cd "$(dirname "$0")"

NO_PULL=${NO_PULL:-0}
NO_BUILD=${NO_BUILD:-0}
NO_TEST=${NO_TEST:-0}
NO_PUSH=${NO_PUSH:-0}

# Source: https://hub.docker.com/_/mariadb

build_mariadb() {
    local channel=$1
    shift
    local series=${channel%-rc}
    local suffix=${channel#"$series"}
    local image="jakubboucek/lamp-devstack-mysql:${channel}"
    local version server_output server_version tag

    if [ "$NO_PULL" -ne 1 ]; then
        docker pull "mariadb:${channel}"
    fi

    if [ "$NO_BUILD" -ne 1 ]; then
        docker build --progress plain -f "mysql/Dockerfile-${series}" -t "$image" mysql/
    fi

    # Tag and push existing output images even when NO_BUILD=1. Never derive
    # their release tag from a potentially newer source image.
    if [ "$NO_BUILD" -ne 1 ] || [ "$NO_TEST" -ne 1 ] || [ "$NO_PUSH" -ne 1 ]; then
        version=$(docker image inspect "$image" \
            --format '{{index .Config.Labels "org.opencontainers.image.version"}}')
        if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || [ "${version%.*}" != "$series" ]; then
            printf 'Invalid MariaDB version label for %s: %s (expected %s.x)\n' "$image" "$version" "$series" >&2
            return 1
        fi

        # This identity check is required for correct tags even with NO_TEST=1.
        # Bypass initialization and configuration; no database server is started.
        server_output=$(docker run --rm --pull=never --entrypoint mariadbd "$image" --no-defaults --version)
        if [[ "$server_output" =~ [[:space:]]Ver[[:space:]]+([0-9]+\.[0-9]+\.[0-9]+)-MariaDB ]]; then
            server_version=${BASH_REMATCH[1]}
        else
            printf 'Cannot parse MariaDB server version for %s: %s\n' "$image" "$server_output" >&2
            return 1
        fi
        if [ "$server_version" != "$version" ]; then
            printf 'MariaDB version mismatch for %s: label=%s server=%s\n' "$image" "$version" "$server_version" >&2
            return 1
        fi

        if [ "$NO_TEST" -ne 1 ]; then
            printf '%s: %s\n' "$image" "$server_output"
        fi

        # RC status is configured by the channel, not exposed by the version label.
        if [ "$NO_BUILD" -ne 1 ] || [ "$NO_PUSH" -ne 1 ]; then
            for tag in "${version}${suffix}" "$@"; do
                docker tag "$image" "jakubboucek/lamp-devstack-mysql:${tag}"
            done
        fi

        if [ "$NO_PUSH" -ne 1 ]; then
            for tag in "${version}${suffix}" "$channel" "$@"; do
                docker push "jakubboucek/lamp-devstack-mysql:${tag}"
            done
        fi
    fi
}

# Channels and publication aliases are explicit; patch versions come from images.
build_mariadb 10.6
build_mariadb 10.11 10
build_mariadb 11.4
build_mariadb 11.8 11
build_mariadb 12.3 12 latest lts
build_mariadb 13.0-rc
