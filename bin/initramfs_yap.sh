#!/bin/bash
if [ -f /boot/initramfs ];then
	mv /boot/initramfs /boot/initramfs_eski
fi
yenimodul=`ls -Art /lib/modules/ | tail -n 1`
modulno=`basename $yenimodul`
dracut -N --force --xz --omit systemd  /boot/initramfs $modulno
