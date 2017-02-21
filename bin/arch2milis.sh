#!/bin/bash
#Milislinux arch pkgbuild dosya terim çevirme betik

if [ -z "$1" ]; then
    echo "kullanım: arch2milis.sh  talimat_yol"
else
	sed -i 's/pkgname/name/g' $1
	sed -i 's/pkgver/version/g' $1
	sed -i 's/pkgrel/release/g' $1
	sed -i 's/pkgdesc/# Description/g' $1
	sed -i 's/{pkgdir}/{PKG}/g' $1
	sed -i 's/{srcdir}/{SRC}/g' $1
	echo "gerekli değişiklikler yapıldı."
fi
