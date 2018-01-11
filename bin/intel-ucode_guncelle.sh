#!/bin/sh
echo "yapım aşamasında"
exit 1
mps guncelle
[ ! -d /var/lib/pkg/DB/iucode-tool ] && mps kur iucode-tool
[ "`mps bil surum intel-ucode`" <> "2.1.15" ] && mps -g intel-ucode
iucode_tool -S --write-earlyfw=/boot/guncel_ucode.cpio /lib/firmware/intel-ucode/*
# gruba eklenecek,
