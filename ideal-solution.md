## The proposed ideal solution
The awesome developers of [JoliOS](https://www.jolicloud.com/jolios) have implemented a neat way of retrieving that, and you can [check it here](https://github.com/jolicloud/lsb/commit/fde07bfec0935784e5caa6cd6a2ff5f81c3d0ad4).

They've implemented a new argument in the `lsb_release` which is `-u` or `--upstream`. It'll read the file located in `/etc/upstream-release/lsb-release` to fetch information about which Ubuntu version it has been derivated. The file is in the same format as `/etc/lsb-release`, but with Ubuntu info:

File **/etc/upstream-release/lsb-release**:
```
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04 LTS"
```

The developers of [elementary OS](http://elementary.io) and [Linux Mint](http://www.linuxmint.com/) have appreciated this implementation and copied it to their distros. This seems of course the nicest way to serve this information to shell script developers, but as this isn't in the LSB specification, only a few distributions support this option.

We who have starred this repository would love to see this option in LSB specification or at least in as many Ubuntu forks as possible. This will indeed make shell script developers lives a lot easier.
