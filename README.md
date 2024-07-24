# dra-tests

This repository is used to generate and store assets for `dra` integration tests.

## Usage

Dependencies:

- [gh](https://github.com/cli/cli)

```bash
./create-release.sh 0.1.0
# output: 0.1.0 release created

./create-release.sh --pre-release 0.1.0
# output: 0.1.0-alpha release created
```

## Assets

- Debian package (`.deb`)
- Tar archives
  - `.tar.{gz,bz2,xz}` with executable
  - `.tar.gz` without executable
- Zip archive (`.zip`)
- Compressed files (`.gz`, `.bz2`, `.xz`)

All assets use the executable [helloworld](helloworld/helloworld).

Both .tar.gz and .zip contains other files and directories other than `helloworld` to simulate real world scenarios.
