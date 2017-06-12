#!/bin/sh

. /lib/dracut-lib.sh

data=$(getarg aufs_root)

if [ ! -z "$data" ] ; then

skip_dirs=$(getarg rfreeze_skip_dirs)

# we can have either "aufs_root=UUID=" or "aufs_root=DIR="
case $data in
    *UUID=* )
        echo "AAA"
        UUID=${data#UUID=}
        DIR=""
        ;;
    *DIR=* )
        UUID=""
        DIR=${data#DIR=}
        ;;
esac

mount -t tmpfs tmpfs /sysroot/tmp 
mkdir /sysroot/tmp/xinos
mkdir /sysroot/tmp/sysroot-rw
mkdir /sysroot/tmp/sysroot-ro
mount -o bind /sysroot /sysroot/tmp/sysroot-ro

RES=0

if [ ! -z "$UUID" ] ; then
    /sbin/fsck.ext2 -y /dev/disk/by-uuid/$UUID  
    mount /dev/disk/by-uuid/$UUID /sysroot/tmp/sysroot-rw && RES=1
fi

if [ ! -z "$DIR" ] ; then
    RES=1
fi

if [ "$RES" = 0 ] ; then 
    mount -n -t tmpfs tmpfs /sysroot/tmp/sysroot-rw
fi

if [ ! -z "$skip_dirs" ] ; then
    SKIP_DIRS=${skip_dirs//:/ }
else
    SKIP_DIRS="dev home lost+found media mnt proc run sys tmp"
fi

for d in `ls /sysroot `
do
    skip_dir=0
    if [ ! -d "/sysroot/$d" ] ; then
	continue
    fi
    for sd in $SKIP_DIRS
    do
        if [ $d = $sd ] ; then
            skip_dir=1
        fi
    done
    if [ $skip_dir = 1 ] ; then
        continue
    fi

    if [ ! -e "/sysroot/tmp/sysroot-rw/$d" ] ; then
	if [ $d = "root" ] ; then
	    mkdir -m 750 "/sysroot/tmp/sysroot-rw/$d"
	else
	    mkdir -m 755 "/sysroot/tmp/sysroot-rw/$d"
	fi
    fi
    if [ ! -d "/sysroot/tmp/sysroot-rw/$d" ] ; then 
	continue
    fi

    if [ ! -z "$DIR" ] ; then
        mount -o bind /sysroot/$DIR/$d /sysroot/tmp/sysroot-rw/$d
    fi

    mount -n -t aufs -o nowarn_perm,noatime,xino=/sysroot/tmp/xinos/$d.xino.aufs,dirs=/sysroot/tmp/sysroot-rw/$d=rw:/sysroot/$d=rr none /sysroot/$d

done

# cp -f /etc/halt /sysroot/etc/init.d/halt
# cp -f /etc/functions /sysroot/etc/init.d/functions

# mount -n -t aufs -o noatime,xino=/xinos/sysroot.xino.aufs,dirs=/sysroot-rw=rw:/sysroot=rr none /sysroot

fi # if [ ! -z "$data" ]

