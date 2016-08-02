: ${BASE_ARCH:=$(uname -m)}
: ${KEYMAP:=tr}
: ${LOCALE:=tr_TR.UTF-8}
: ${INITRAMFS_COMPRESSION:=xz}
: ${SQUASHFS_COMPRESSION:=xz}
: ${BOOT_TITLE:="Milis_Linux"}

readonly CURDIR="$PWD"

ISO_VOLUME="MILIS_LIVE"

IMAGEDIR="iso_icerik"
IMAGEDIR=$(readlink -f $IMAGEDIR)
BOOT_DIR="$IMAGEDIR/boot"
ISOLINUX_DIR="$BOOT_DIR/isolinux"
GRUB_DIR="$BOOT_DIR/grub"
ISOLINUX_CFG="$ISOLINUX_DIR/isolinux.cfg"
SPLASH_IMAGE="$ISOLINUX_DIR/back.jpg"
#noaer vs yazabiliriz.
BOOT_CMDLINE=""
KERNELVERSION=`uname -r`
mkdir -p $GRUB_DIR
cp -f grub/grub.cfg $GRUB_DIR/
cp -f grub/grub_milis.cfg.in $GRUB_DIR/grub_milis.cfg
sed -i  -e "s|@@SPLASHIMAGE@@|$(basename ${SPLASH_IMAGE})|" \
	-e "s|@@KERNVER@@|${KERNELVERSION}|" \
	-e "s|@@KEYMAP@@|${KEYMAP}|" \
	-e "s|@@ARCH@@|$BASE_ARCH|" \
	-e "s|@@BOOT_TITLE@@|${BOOT_TITLE}|" \
	-e "s|@@BOOT_CMDLINE@@|${BOOT_CMDLINE}|" \
	-e "s|@@LOCALE@@|${LOCALE}|" $GRUB_DIR/grub_milis.cfg

mkdir -p $GRUB_DIR/fonts
cp -f grub/fonts/unicode.pf2 $GRUB_DIR/fonts/

modprobe -q loop || :

# EFI vfat imajı olusturuyoruz.
truncate -s 16M $GRUB_DIR/efiboot.img >/dev/null 2>&1
mkfs.vfat -F12 -S 512 -n "grub_uefi" "$GRUB_DIR/efiboot.img" >/dev/null 2>&1

GRUB_EFI_TMPDIR="$(mktemp --tmpdir=/tmp -d)"
LOOP_DEVICE="$(losetup --show --find ${GRUB_DIR}/efiboot.img)"
mount -o rw,flush -t vfat "${LOOP_DEVICE}" "${GRUB_EFI_TMPDIR}" >/dev/null 2>&1

cp -a $IMAGEDIR/boot $LFS

chroot $LFS grub-mkstandalone -- \
		 --directory="/usr/lib/grub/x86_64-efi" \
		 --format="x86_64-efi" \
		 --output="/tmp/bootx64.efi" \
		 "boot/grub/grub.cfg"
if [ $? -ne 0 ]; then
		umount "$GRUB_EFI_TMPDIR"
		losetup --detach "${LOOP_DEVICE}"
		echo "Failed to generate EFI loader"
		exit 1
fi
mkdir -p ${GRUB_EFI_TMPDIR}/EFI/BOOT
cp -f $LFS/tmp/bootx64.efi ${GRUB_EFI_TMPDIR}/EFI/BOOT/BOOTX64.EFI
fi
umount "$GRUB_EFI_TMPDIR"
losetup --detach "${LOOP_DEVICE}"
rm -rf $GRUB_EFI_TMPDIR
