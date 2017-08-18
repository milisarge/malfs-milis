#!/bin/bash
# gnome iso yapma
# lfs dizini oluşturup ortama girdikten sonra bu betiği çalıştırabilirsiniz,bütün ortam içi işlemler yapılacaktır.
masaustu="gnome"
girisyonetici="slim"
mps kur linux-firmware
mps kur lsb-release
mps kur kernel
[ -f /usr/bin/dracut ] && rm -rf /usr/bin/dracut
mps kur dracut
mps kur xorg
mps kur xf86-video-openchrome
mps -kuruld /root/talimatname/temel-ek/derleme.sira
mps kur $masaustu
mps kur $masaustu-ekstra
mps kur milis-yukleyici
# girisci kurulum
mps -kurul /root/ayarlar/gerekli_programlar_$masaustu
mps kur $girisyonetici
mps sil python-gobject && mps kur python-gobject
cp /root/ayarlar/.xinitrc.$masaustu /root/.xinitrc
cp -r /root/ayarlar/$masaustu/.config /root/
cp /root/ayarlar/network /etc/sysconfig/
tamir_touchpad
tamir_font
update-mime-database /usr/share/mime
gtk-update-icon-cache
gio-querymodules /usr/lib/gio/modules
glib-compile-schemas /usr/share/glib-2.0/schemas/
xdg-icon-resource forceupdate --theme hicolor
gdk-pixbuf-query-loaders --update-cache
update-desktop-database -q
/usr/bin/gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'tr')]"
export LC_ALL="tr_TR.UTF-8"
export LANG="tr_TR.UTF-8"
xdg-user-dirs-update
cp -rf /sources/milis.git/ayarlar/milbit/milbit.desktop /usr/share/applications/
cp /usr/share/applications/yukleyici.desktop /root/Masaüstü/
chmod +x /root/Masaüstü/yukleyici.desktop
rm -f /root/.gitconfig

if [ -f /usr/bin/slim ];then
	cp -f /root/ayarlar/.xinitrc-$masaustu.slim /root/.xinitrc
fi
if [ -f /usr/bin/lxdm ];then
	cp -rf /sources/milis.git/ayarlar/servisler/mbd/init.d/lxdm /etc/init.d/
fi

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

