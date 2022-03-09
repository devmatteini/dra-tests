#!/usr/bin/env bash

readonly BUILD_DIR="build-tar"
readonly HELLOWORLD_DIR="$BUILD_DIR/helloworld"

# Create build directory
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# Create directory to compress
mkdir "$HELLOWORLD_DIR"
cp helloworld/helloworld "$HELLOWORLD_DIR"
# also add some random files and directories
touch "$HELLOWORLD_DIR"/LICENSE
touch "$HELLOWORLD_DIR"/README.md
mkdir "$HELLOWORLD_DIR"/notes
touch "$HELLOWORLD_DIR"/notes/latest.txt

# Compress archive
mkdir -p out/
tar czf out/helloworld.tar.gz -C "$BUILD_DIR" helloworld/ 


