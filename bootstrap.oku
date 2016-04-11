//milis sisteminin kurulabilmesi için öndosyalar ve gerekli ayarlar yapılır.

./lfs-mekanizma -ia

//mps-bootstrap içindeki sunucu="ip:port/"  şeklinde paket depo adresi ayarlandıktan sonra

//paket güncellemesi yapılır 

./mps-bootstrap -G

//temel-sistem kurulumu için.

./mps-bootstrap -psk talimatname/temel/derleme.sira /mnt/lfs/

//temel-sistemi yedeklemek için-chroot olarak kullanılmak üzere

./lfs-mekanizma -ts

//temel-ek-sistem kurulumu için.(kernel-grub-initrd vs.)

./mps-bootstrap -psk talimatname/temel-ek/derleme.sira /mnt/lfs/

//temel-sistemi yedeklemek için-iso üretilecek chroot olarak kullanılmak üzere

./lfs-mekanizma -ss

//gerekli ayarlamalar için chroot içine girilir.

./lfs-mekanizma -cg

//yukarıdaki komuttan sonra işlemler chroot içinde olacak!

cd /tmp

rm *.PRE

for i in *.POST; do bash "$i"; done

//sorunsuz calisirsa kur-kos betikleri silinebilir.

rm *.POST

//initrd yapmak için

cd /root

./lfs-mekanizma -bo

//temel sistem için paket durum tarihçesi oluşturulur.

mps -trot

exit

// yukarıdaki komut ile chroot dışına çıkılıp iso yapılır.

//aşağıdaki iki komut ile iso yapılır.

./lfs-mekanizma -so

./lfs-mekanizma -io

//test etmek için

./qemu.sh

//not: giriş için kullanıcı:root şifre:milis
