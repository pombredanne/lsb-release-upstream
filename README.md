# LSB Release Upstream
Manually detecting upstream Linux distros for shell scripting.

## Problem
You need to add an apt repository in the installation script of your application, and you're used to do that with the help of the `lsb_release` command. Though, we've got tens of Linux distributions forked from Ubuntu and some from Debian, and that command will return the derived distribution name. It's not usual to have new apt repositories for each new derivative distro, because you're fine to use the Ubuntu repositories.

But what version of Ubuntu repositories would you use? Trusty, Saucy, Precise? How do you programatically determine that?

## The palliative solution
As there isn't any default and broadly supported way of getting that, this repository is intended to be a public database for serving these valuable information.

All you need to do is to copy the `detect-upstream.sh` file from this repository to your setup and source it in your script. You'll profit anytime new Linux distributions are added to this repository.

File **example.sh**:
```
#!/bin/sh

. ./detect-upstream.sh
echo "Upstream Linux distribution is '$lsb_dist' version '$dist_version'."
```

If this script is executed in elementary OS Freya, for example, you'd have `$lsb_dist=ubuntu` and `$dist_version=trusty`, which is the corresponding Ubuntu version it has derivated from.

## The ideal solution (I think)
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

## Spread the love
If you also think the ideal solution is the implementation of the `lsb_release -u` option across as many distributions as possible, please help us spread the love.

Share this repository with everybody so we can someday reach developers from other distros.

# License
MIT.
