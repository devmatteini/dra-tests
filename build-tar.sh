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

function create_archive_without_root_directory(){
    local dir
    local out_dir
    dir="$1"
    out_dir="$2"

    (cd "$dir" && tar czf "$out_dir" *)
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
create_archive_without_root_directory "$HELLOWORLD_DIR" "$(pwd)/out/no_root_directory.tar.gz"
