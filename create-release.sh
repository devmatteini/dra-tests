#!/bin/bash

function usage(){
    echo "usage $(basename "$0") <version>" 
    echo
    echo "ARGS:"
    echo "    <version>    release version x.y.z (e.g 1.3.0)" 
    exit 1
}

if [[ -z $1 ]]; then usage; fi
if [[ $1 == *v* ]]; then echo "Version format must be: x.y.z (e.g 1.3.0)"; usage; fi
if ! command -v gh > /dev/null; then echo "Missing gh command"; usage; fi

version="$1"

git tag "$version"

rm -rf out/
mkdir -p out/
make build

git push
git push --tags

# Create release and upload all files inside out/ dir
gh release create "$version" \
    --title "$version" \
    --notes "dra-tests release $version" \
    -R devmatteini/dra-tests \
    out/*
