#!/bin/bash
# lfs dizini oluşturup ortama girdikten sonra bu betiği çalıştırabilirsiniz,bütün ortam içi işlemler yapılacaktır.
masaustu="xfce4"
mps -GG && mps -G
mps -kuruld /root/talimatname/temel-ek/derleme.sira
mps kur $masaustu
mps -kurul /root/ayarlar/gerekli_programlar
cp /root/ayarlar/.xinitrc.$masaustu /root/.xinitrc
cp -r /root/ayarlar/$masaustu/.config /root/
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
export LC_ALL="tr_TR.UTF-8"
export LANG="tr_TR.UTF-8"
xdg-user-dirs-update
if [ -f /usr/bin/slim ];then
	cp -r ayarlar/slim-milis /usr/share/slim/themes/milis
	cp /sources/milis.git/ayarlar/slim-milis/slim.conf /etc/
fi
cp ayarlar/kurulum.desktop /root/Desktop/
cp ayarlar/kurulum.desktop /root/Masaüstü/
tamir_masaustu
