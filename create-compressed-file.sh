#!/usr/bin/env bash

mkdir -p out/

UNIX_SOURCE="helloworld/helloworld"
WINDOWS_SOURCE="helloworld-windows/helloworld.exe"

# Unix
gzip -c "$UNIX_SOURCE" > out/helloworld-compressed-unix.gz
bzip2 -c "$UNIX_SOURCE" > out/helloworld-compressed-unix.bz2
xz -c "$UNIX_SOURCE" > out/helloworld-compressed-unix.xz

# Windows
gzip -c "$WINDOWS_SOURCE" > out/helloworld-compressed-windows.gz
bzip2 -c "$WINDOWS_SOURCE" > out/helloworld-compressed-windows.bz2
xz -c "$WINDOWS_SOURCE" > out/helloworld-compressed-windows.xz
