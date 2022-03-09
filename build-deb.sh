#!/usr/bin/env bash

readonly BUILD_DIR="build-debian"
readonly HELLOWORLD_DIR="$BUILD_DIR/helloworld"
readonly HELLOWORLD_BIN="$HELLOWORLD_DIR/usr/local/bin"

# Create build directory
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# Create debian package structure
mkdir -p "$HELLOWORLD_DIR"/DEBIAN
mkdir -p "$HELLOWORLD_BIN"
cat > "$HELLOWORLD_DIR"/DEBIAN/control<< EOF
Package: helloworld
Version: 0.1.0
Section: development
Priority: optional
Architecture: all
Maintainer: info@example.com
Description: helloworld cli
EOF
cp helloworld/helloworld "$HELLOWORLD_BIN"/helloworld

# Build .deb file
dpkg-deb --build "$HELLOWORLD_DIR"

# Move .deb file to out directory
mkdir -p out/
mv "$BUILD_DIR"/helloworld.deb out/
