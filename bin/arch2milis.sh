#!/bin/bash
#Milislinux arch pkgbuild dosya terim çevirme betik

if [ -z "$1" ]; then
    echo "kullanım: arch2milis.sh  talimat_yol"
else
	sed -i 's/pkgname/isim/g' $1
	sed -i 's/pkgver/surum/g' $1
	sed -i 's/pkgrel/devir/g' $1
	sed -i 's/pkgdesc/# Tanım/g' $1
	sed -i 's/{pkgdir}/{PKG}/g' $1
	sed -i 's/pkgdir/PKG/g' $1
	sed -i 's/{srcdir}/{SRC}/g' $1
	sed -i 's/srcdir/SRC/g' $1
	echo "gerekli değişiklikler yapıldı."
fi
