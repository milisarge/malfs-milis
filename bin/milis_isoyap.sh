#!/bin/bash
# lfs dizini oluşturup ortama girdikten sonra bu betiği çalıştırabilirsiniz,bütün ortam içi işlemler yapılacaktır.

if [ ! "$2" ]; then
	echo "ayar dosyası belirtiniz."
	exit 1
else
	source "$2"
	echo "masaüstü: $masaustu" 
	echo "giris yoneticisi: $girisyonetici" 
	echo "ek paket listesi: $ekpaketliste" 
	echo "yerel ayarlar: $yerel" 
	while true; do
		echo " ayarlar uygulansın mı?";read -p "e veya h-> " eh
		case $eh in
			[Ee]* ) isokur $masaustu $girisyonetici $ekpaketliste $yerel; break;;
			[Hh]* ) break;;
			* ) echo "e veya h";;
		esac
	done
fi

isokur(){
	masaustu="$1"
	girisyonetici="$2"
	ekpaketliste="$3"
	yerel="$4"
	mps kur linux-firmware
	mps kur kernel
	mps kur dracut
	mps kur xorg
	mps -kuruld /root/talimatname/temel-ek/derleme.sira
	mps kur $masaustu
	# girisci kurulum
	mps kur $girisyonetici
	mps -kurul "$ekpaketliste"
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
	export LC_ALL="$yerel"
	export LANG="$yerel"
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
	tamir_masaustu

}
