#!/bin/sh -x
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

masa="lxqt"

echo "pisilinux" > ${NEWROOT}/etc/hostname

USERNAME=$(getarg live.user)
USERSHELL=$(getarg live.shell)

[ -z "$USERNAME" ] && USERNAME=pisix
[ -x $NEWROOT/bin/bash -a -z "$USERSHELL" ] && USERSHELL=/bin/bash
[ -z "$USERSHELL" ] && USERSHELL=/bin/sh

# Create /etc/default/live.conf to store USER.
echo "USERNAME=$USERNAME" >> ${NEWROOT}/etc/default/live.conf
chmod 644 ${NEWROOT}/etc/default/live.conf

if ! grep -q ${USERSHELL} ${NEWROOT}/etc/shells ; then
    echo ${USERSHELL} >> ${NEWROOT}/etc/shells
fi

# Create new user and remove password. We'll use autologin by default.

#chroot ${NEWROOT} sh -c "groupadd -g 18 'messagebus' "
#chroot ${NEWROOT} sh -c "useradd -m -d /var/run/dbus -r -s /bin/false -u 18 -g 18 'messagebus' -c 'D-Bus Message Daemon' "

chroot ${NEWROOT} sh -c 'useradd -m -c $USERNAME -G audio,video,wheel,utmp -s $USERSHELL $USERNAME'
chroot ${NEWROOT} sh -c "groupadd -fg 84 avahi && useradd -c 'Avahi Daemon Owner' -d /var/run/avahi-daemon -u 84 -g avahi -s /bin/false avahi"
chroot ${NEWROOT} sh -c "passwd -d $USERNAME >/dev/null 2>&1"

# Setup default root/user password (pisilinux).
chroot ${NEWROOT} sh -c 'echo "root:toor" | chpasswd -c SHA512'
chroot ${NEWROOT} sh -c 'echo $USERNAME:pisix | chpasswd -c SHA512'

#gerekli ayarlar
#chroot ${NEWROOT} sh -c "chmod +x /usr/local/bin/tamir"
#chroot ${NEWROOT} sh -c  "mkdir -p /run/lock/files.ldb && touch /run/lock/files.ldb/LOCK"
echo "tamir" >> ${NEWROOT}/root/.xinitrc
echo "exec start"$masa >> ${NEWROOT}/root/.xinitrc
echo "tamir" >> ${NEWROOT}/home/$USERNAME/.xinitrc
echo "exec start"$masa >> ${NEWROOT}/home/$USERNAME/.xinitrc


# Enable sudo permission by default.
if [ -f ${NEWROOT}/etc/sudoers ]; then
    echo "${USERNAME}  ALL=(ALL) NOPASSWD: ALL" >> ${NEWROOT}/etc/sudoers
fi

cp /run/initramfs/live/boot/kernel $NEWROOT/boot/kernel





