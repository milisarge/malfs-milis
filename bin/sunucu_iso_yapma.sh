#!/bin/bash
# sunucu iso yapma
# lfs dizini oluşturup ortama girdikten sonra bu betiği çalıştırabilirsiniz,bütün ortam içi işlemler yapılacaktır.
rm -rf /usr/bin/dracut
mps -kuruld /root/talimatname/temel-ek/derleme.sira
mps kur linux-firmware
mps kur lsb-release
mps kur kernel
mps kur dracut
mps -kurul /root/ayarlar/gerekli_programlar_sunucu
cp /root/ayarlar/network /etc/sysconfig/
cd /var/lib/pkg/DB
grep -rli '/mnt/lfs' * | xargs -i@ sed -i 's/\/mnt\/lfs\///g' @
cd /root/
if [ ! -f /usr/bin/dracut ];then
	tamir_dracut
fi
./lfs-mekanizma -bo
rm -r /depo/paketler/*
mv /var/lib/pkg/tarihce/temel-pkvt.tar.lz /var/lib/pkg/tarihce/temel2-pkvt.tar.lz
rm -r /tmp/*
mps -tro
