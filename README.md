# dra-tests

This repository is used to generate and store assets for `dra` integration tests.

## Usage

Dependencies:

- [gh](https://github.com/cli/cli)

```bash
$ ./create-release.sh 0.1.0
```

## Assets

- Debian package (.deb)
- Tar archive (.tar.gz)
- Zip archive (.zip)

All assets use the executable [helloworld](helloworld/helloworld).

Both .tar.gz and .zip contains other files and directories other than `helloworld` to simulate real world scenarios.
