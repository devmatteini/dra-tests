#!/usr/bin/env bash

readonly BUILD_DIR="build-tar"
readonly HELLOWORLD_DIR="$BUILD_DIR/helloworld"
readonly HELLOWORLD_WINDOWS_DIR="$BUILD_DIR/helloworld-windows"
readonly NO_EXECUTABLE_DIR="$BUILD_DIR/no_executable"
readonly HELLOWORLD_BIN_DIR="$BUILD_DIR/helloworld-bin"
readonly HELLOWORLD_MANY_EXECUTABLES_DIR="$BUILD_DIR/helloworld-many-executables"

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

function prepare_helloworld_windows(){
    local dir
    dir="$1"

    mkdir "$dir"
    cp helloworld-windows/helloworld.exe "$dir"
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

function prepare_helloworld_bin(){
    local dir
    dir="$1"

    mkdir "$dir"
    mkdir "$dir/bin"
    cp helloworld/helloworld "$dir/bin/helloworld"
    touch "$dir"/LICENSE
    touch "$dir"/README.md
    mkdir "$dir"/notes
    touch "$dir"/notes/latest.txt
}

function prepare_many_executables(){
    local dir
    dir="$1"

    mkdir "$dir"
    cp helloworld/helloworld "$dir/install.sh"
    cp helloworld/helloworld "$dir/helloworld-v2"
    cp helloworld/helloworld "$dir/random-script"
}

function create_archive_without_root_directory(){
    local dir
    local out_file
    dir="$1"
    out_file="$2"

    (cd "$dir" && tar czf "$out_file" *)
}

# Create build directory
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

prepare_helloworld "$HELLOWORLD_DIR"
prepare_no_executable "$NO_EXECUTABLE_DIR"
prepare_helloworld_windows "$HELLOWORLD_WINDOWS_DIR"
prepare_helloworld_bin "$HELLOWORLD_BIN_DIR"
prepare_many_executables "$HELLOWORLD_MANY_EXECUTABLES_DIR"

# Compress archives
mkdir -p out/

create_archive_without_root_directory "$HELLOWORLD_DIR" "$(pwd)/out/no_root_directory.tar.gz"

# Unix
tar czf out/helloworld.tar.gz -C "$BUILD_DIR" helloworld/ 
tar czf out/helloworld.tgz -C "$BUILD_DIR" helloworld/ 
tar czf out/no_executable.tar.gz -C "$BUILD_DIR" no_executable/
tar cjf out/helloworld.tar.bz2 -C "$BUILD_DIR" helloworld/ 
tar cJf out/helloworld.tar.xz -C "$BUILD_DIR" helloworld/ 
tar czf out/helloworld-x86_64-linux.tar.gz -C "$BUILD_DIR" helloworld/
tar czf out/helloworld-bin.tar.gz -C "$BUILD_DIR" helloworld-bin/
tar czf out/helloworld-many-executables-unix.tar.gz -C "$BUILD_DIR" helloworld-many-executables/ 

# Windows
tar czf out/helloworld-windows.tar.gz -C "$BUILD_DIR" helloworld-windows/ 
tar czf out/helloworld-x86_64-windows.tar.gz -C "$BUILD_DIR" helloworld-windows/ 

# macOS
tar czf out/helloworld-x86_64-apple-darwin.tar.gz -C "$BUILD_DIR" helloworld/ 
tar czf out/helloworld-aarch64-apple-darwin.tar.gz -C "$BUILD_DIR" helloworld/ 
