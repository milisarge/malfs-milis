#!/bin/bash

# called by dracut
check() {
    return 0
}

# called by dracut
depends() {
    return 0
}

# called by dracut
installkernel() {
    instmods aufs
}

# called by dracut
install() {
    inst_multiple -o fsck.ext2 fsck.ext4 fsck.ext3

    inst_hook pre-pivot 10 "$moddir/aufs-mount.sh"
}
