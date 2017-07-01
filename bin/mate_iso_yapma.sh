#!/bin/bash
# mate iso yapma
# lfs dizini oluşturup ortama girdikten sonra bu betiği çalıştırabilirsiniz,bütün ortam içi işlemler yapılacaktır.
masaustu="mate"
girisyonetici="slim"
mps kur linux-firmware
mps kur kernel
mps kur dracut
mps kur xorg
mps -kuruld /root/talimatname/temel-ek/derleme.sira
mps kur $masaustu
# girisci kurulum
mps kur $girisyonetici
mps -kurul /root/ayarlar/gerekli_programlar_$masaustu
mkdir /usr/share/backgrounds/milis
cp /root/ayarlar/mate/milis-arkaplan/* /usr/share/backgrounds/milis/
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
	cp -f /root/ayarlar/.xinitrc-$masaustu.slim /root/.xinitrc
fi
if [ -f /usr/bin/lxdm ];then
	cp -rf /sources/milis.git/ayarlar/servisler/mbd/init.d/lxdm /etc/init.d/
fi
cp -rf /sources/milis.git/ayarlar/milbit/milbit.desktop /usr/share/applications/
cp ayarlar/kurulum.desktop /root/Desktop/
cp ayarlar/kurulum.desktop /root/Masaüstü/
tamir_touchpad
tamir_mate_logo
tamir_masaustu
