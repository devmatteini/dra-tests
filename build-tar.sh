#!/usr/bin/env bash

readonly BUILD_DIR="build-tar"
readonly HELLOWORLD_DIR="$BUILD_DIR/helloworld"
readonly NO_EXECUTABLE_DIR="$BUILD_DIR/no_executable"

function prepare_helloworld(){
    local dir
    dir="$1"

    mkdir "$dir"
    cp helloworld/helloworld "$dir"
    touch "$dir"/LICENSE
    touch "$dir"/README.md
    mkdir "$dir"/notes
    touch "$dir"/notes/latest.txt
}

function prepare_no_executable(){
    local dir
    dir="$1"

    mkdir "$dir"
    touch "$dir"/LICENSE
    touch "$dir"/README.md
    mkdir "$dir"/notes
    touch "$dir"/notes/latest.txt
}

# Create build directory
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

prepare_helloworld "$HELLOWORLD_DIR"
prepare_no_executable "$NO_EXECUTABLE_DIR"

# Compress archives
mkdir -p out/
tar czf out/helloworld.tar.gz -C "$BUILD_DIR" helloworld/ 
tar czf out/no_executable.tar.gz -C "$BUILD_DIR" no_executable/
tar cjf out/helloworld.tar.bz2 -C "$BUILD_DIR" helloworld/ 
tar cJf out/helloworld.tar.xz -C "$BUILD_DIR" helloworld/ 
