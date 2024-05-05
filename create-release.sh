#!/usr/bin/env bash

function usage(){
    echo
    echo "usage $(basename "$0") <VERSION> [--pre-release]"
    echo
    echo "OPTIONS:"
    echo "    [--pre-release]    create a pre-release"
    echo
    echo "ARGS:"
    echo "    <VERSION>          release version x.y.z (e.g 1.3.0)"
    exit 1
}

if [ $# -eq 0 ] || [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    usage
fi

if ! command -v gh > /dev/null; then 
    echo "Missing gh command"
    usage
fi

pre_release="false"
version=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --pre-release)
            pre_release="true"
            shift
            ;;
        *)
            if [ -z "$version" ]; then
                version="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$version" ]; then
    echo "Error: <VERSION> argument is missing"
    usage
fi

if [[ $version == *v* ]]; then 
    echo "Version format must be: x.y.z (e.g 1.3.0)"
    usage 
fi

echo "Version: $version"
echo "Pre release: $pre_release"

release="$version"
if [[ "$pre_release" == "true" ]]; then
    release="$version-alpha"
fi

release_notes="dra-tests release $release"

git tag -s "$release" -m "$release_notes"

rm -rf out/
mkdir -p out/
make build

# Create some assets with version inside filename
cp out/helloworld.tar.gz out/"helloworld_${release}.tar.gz"
cp out/helloworld.deb out/"helloworld_${release}_amd64.deb"

git push
git push --tags

gh_release_create_options=(
    "$release"
    --title "$release"
    --notes "$release_notes"
    -R devmatteini/dra-tests
)

if [[ "$pre_release" == "true" ]]; then
    gh_release_create_options+=("--prerelease")
fi

# Create release and upload all files inside out/ dir
gh release create "${gh_release_create_options[@]}" out/*
