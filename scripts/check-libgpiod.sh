#!/bin/sh
# Checks for the libgpiod >= 2.2 C++ development files before node-gyp builds the addon, so a
# missing or outdated package gives a clear message instead of a compiler error.

REQUIRED_VERSION="2.2"
PACKAGE_NAME="libgpiod-dev"

if [ "$CI" = "true" ]; then
    echo "opengpio: libgpiod check skipped in CI"
    exit 0
fi

fail() {
    echo "opengpio: $1" >&2
    echo "opengpio: install the libgpiod 2.2 (or newer) development files, on Debian / Raspberry Pi OS:" >&2
    echo "opengpio:     sudo apt install $PACKAGE_NAME" >&2
    echo "opengpio: Debian 13 (Trixie) and newer ship libgpiod 2.2; Debian 12 (Bookworm) only has 1.6." >&2
    exit 1
}

if command -v pkg-config >/dev/null 2>&1 && pkg-config --exists libgpiodcxx; then
    INSTALLED_VERSION=$(pkg-config --modversion libgpiodcxx)
    if pkg-config --atleast-version="$REQUIRED_VERSION" libgpiodcxx; then
        echo "opengpio: libgpiodcxx $INSTALLED_VERSION found"
        exit 0
    fi
    fail "libgpiodcxx $INSTALLED_VERSION is too old, $REQUIRED_VERSION or newer is required."
fi

if command -v dpkg >/dev/null 2>&1; then
    INSTALLED_VERSION=$(dpkg -s "$PACKAGE_NAME" 2>/dev/null | grep '^Version:' | awk '{print $2}')
    if [ -z "$INSTALLED_VERSION" ]; then
        fail "$PACKAGE_NAME is not installed."
    fi
    if dpkg --compare-versions "$INSTALLED_VERSION" ge "$REQUIRED_VERSION"; then
        echo "opengpio: $PACKAGE_NAME $INSTALLED_VERSION found"
        exit 0
    fi
    fail "$PACKAGE_NAME $INSTALLED_VERSION is too old, $REQUIRED_VERSION or newer is required."
fi

# neither pkg-config nor dpkg know about libgpiod, e.g. a self-built library: let the build decide
echo "opengpio: could not determine the libgpiod version, trying to build anyway"
