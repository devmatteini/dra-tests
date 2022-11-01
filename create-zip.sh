#!/usr/bin/env bash

readonly BUILD_DIR="build-zip"
readonly HELLOWORLD_DIR="$BUILD_DIR/helloworld"
readonly HELLOWORLD_WINDOWS_DIR="$BUILD_DIR/helloworld-windows"

function create_zip_without_root_directory(){
    local dir
    local out_file
    dir="$1"
    out_file="$2"

    (cd "$dir" && zip -r "$out_file" .)
}

# Create build directory
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# Create directory to compress - Unix
mkdir "$HELLOWORLD_DIR"
cp helloworld/helloworld "$HELLOWORLD_DIR"
# also add some random files and directories
touch "$HELLOWORLD_DIR"/LICENSE
touch "$HELLOWORLD_DIR"/README.md
mkdir "$HELLOWORLD_DIR"/notes
touch "$HELLOWORLD_DIR"/notes/latest.txt

# Create directory to compress - Windows
mkdir "$HELLOWORLD_WINDOWS_DIR"
cp helloworld-windows/helloworld.exe "$HELLOWORLD_WINDOWS_DIR"
touch "$HELLOWORLD_WINDOWS_DIR"/LICENSE
touch "$HELLOWORLD_WINDOWS_DIR"/README.md
mkdir "$HELLOWORLD_WINDOWS_DIR"/notes
touch "$HELLOWORLD_WINDOWS_DIR"/notes/latest.txt

# Compress archive
mkdir -p out/
(cd "$BUILD_DIR" && zip -r ../out/helloworld.zip helloworld)
(cd "$BUILD_DIR" && zip -r ../out/helloworld-windows.zip helloworld-windows)
create_zip_without_root_directory "$HELLOWORLD_DIR" "$(pwd)/out/no_root_directory.zip"

