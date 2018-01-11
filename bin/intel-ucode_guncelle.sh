#!/bin/sh
mps guncelle
#[ ! -d /var/lib/pkg/DB/iucode-tool ] && mps kur iucode-tool
[ "`mps bil surum intel-ucode`" <> "2.1.15" ] && mps -g intel-ucode
echo "early_microcode=yes" >>  /usr/lib/dracut/dracut.conf.d/intel_ucode.conf
# buna gerek yok dracut oto dahil ediyor.
#iucode_tool -S --write-earlyfw=/boot/guncel_ucode.cpio /lib/firmware/intel-ucode/*
initramfs_guncelle
grub-guncelle
