#malf-milis in klonladığınız dizine giriniz.
#mps-bootstrap da gerekli ikili paket sunucu ayarını yapınız.
#./chroot-yapici çalıştırın.
export LFS=/mnt/lfs
if [ -d /mnt/lfs ];then
	rm -r /mnt/lfs
fi
./lfs-mekanizma -ia
./mps-bootstrap -G
./mps-bootstrap -psk talimatname/temel/derleme.sira /mnt/lfs/
./mps-bootstrap -ik git -kok /mnt/lfs
chroot "/mnt/lfs" sh -c "/root/bin/otopostpre.sh"
mksquashfs /mnt/lfs /mnt/milis_bootstrap.sfs -comp xz
