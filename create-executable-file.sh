#!/usr/bin/env bash

mkdir -p out/

UNIX_SOURCE="helloworld/helloworld"
WINDOWS_SOURCE="helloworld-windows/helloworld.exe"

# Unix
mv "$UNIX_SOURCE" out/helloworld-unix

# Windows
mv "$WINDOWS_SOURCE" out/helloworld-windows.exe
