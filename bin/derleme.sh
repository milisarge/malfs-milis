#!/bin/bash
echo "**** Milis Linux Derleme Alanına Gitmenizi Sağlar. ****"
echo "**** İşlem sonrası mps -GG ve mps -G komutlarını veriniz. ****"

cd /sources/milis.git
	echo "sources/milis.git yapıldı"
export LFS=/mnt/lfs
	echo "LFS=/mnt/lfs yapıldı"
./lfs-mekanizma  -cg
