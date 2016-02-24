# malfs
Milis Automated Linux From Scratch

 Konak Sistem için Yapılması Gerekenler (ubuntu)
 
 apt-get remove mawk
 
 apt-get install bsdtar binutils gcc g++ m4 make bison texinfo pkg-config squashfs-tools
 
 rm /bin/sh
 
 ln -s /bin/bash /bin/sh
 
 KURULUM YÖNERGELERİ

 Dikkat:
 1-Bu işlemleri root kullanıcısıyla yapınız.
 
 -Mekanizmanın Kurulması
 
 git clone https://github.com/milisarge/malfs-milis.git malfs
 
 cd malfs
 
 ilk önce host sistemin gereksinimleri karşıladığının kontrol edilmesi
 
 root@makine:/opt/malfs# ./lfs-mekanizma -gk
 
 yukarıdaki işlemin sonucuna göre gerekli gereksinimler yuklenir.
 
 ayrıca http://www.linuxfromscratch.org/lfs/view/development/prologue/hostreqs.html sayfasından versiyon kontrolü yapınız.

 gereksinimler tamamlandıktan sonra gerekli ortam değişkeni ayarı yapılır.

 root@makine:/opt/malfs# mkdir -p /mnt/lfs

 root@makine:/opt/malfs# export LFS=/mnt/lfs

 gerekli kaynak kodların indirilmesi 
 
 root@makine:/opt/malfs# ./lfs-mekanizma -ki

 birinci ayarlar yapılır
 
 root@makine:/opt/malfs# ./lfs-mekanizma -ba

 lfs kullanıcısıyla oturum acılmış olur.önsistem derlenmeye baslanır.
 
 lfs@makine:~$ ./lfs-mekanizma -td onsistem

 =======>  '/home/lfs/talimatname/onsistem/0mps/0mps#0.1-x86_64.mps.lz' derleme basarili
 
 yukarıdaki ifade goruldukten sonra exit komutu ile lfs kullanıcısından çıkılır.

 lfs önsistemin sıkıstırılması(yedeklemek için)

 root@makine:/opt/malfs# ./lfs-mekanizma -os

 üretici önsistemin yedeklenmesinden sonra üretici sisteme girmek için gerekli ayarlar yapılır.

 root@makine:/opt/malfs# ./lfs-mekanizma -ia
 
 üretici sisteme girilir.

 root@makine:/opt/malfs# ./lfs-mekanizma -cg

 root [ / ]#   ekranına düşülür."command not found" şeklinde hatalar görülebilir,normaldir.bash yuklemesinden sonra düzelecek.

 üretici sistem içersindeyken gerekli exportlar yapılır.

 root [ / ]#  export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin:/root/bin
 
 root [ / ]#  export FORCE_UNSAFE_CONFIGURE=1 

 root dizinine girilir.
 
 root [ / ]#  cd /root

 root [ / ]#  ./lfs-mekanizma -td temel

 komutu verilip temel sistemin kurulumu sağlanır.

 "bash chroot dışına çıkıp elle kurulmalıdır."  mesajı görülünce
 
 "exit" ile chroot dışına çıkılır

 root@makine:/opt/malfs# ./lfs-mekanizma -bk

 komutu verilip bash kurulumu sağlanır.işlem aşağıdaki şekilde sonlanmalıdır.
 
 bash 4.3.30-3
 
 bash.tr 4.3.30-3

 tekrar chroot içine girilir.ortam değişkenleri ayarlandıktan sonra,temel sistem derlenmeye devam edilir.

 root@makine:/opt/malfs# ./lfs-mekanizma -cg
 
 root [ / ]#  export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin:/root/bin
 
 root [ / ]#  export FORCE_UNSAFE_CONFIGURE=1
 
 root [ / ]#  cd /root

 root [ / ]#  ./lfs-mekanizma -td temel
 
 en son aşağıdaki mesaj ile derleme bitmelidir.
 
 =======>  'ca-certificates#20160110-x86_64.mps.xz' basarili sekilde kuruldu.

 temel sistem paketlerin paket_depo altında toplanması-paketlerin arsivlenmesi

 root [ / ]#  paketleri_arsivle

 chroottan cıkılıp,temel sistemin yedegi alınır.

 root [ / ]#  exit 
 
 root@makine:/opt/malfs# ./lfs-mekanizma -ts

 tekrar chroot içine girilir.ortam değişkenleri ayarlandıktan sonra,temel sistem için gerekli ek paketler derlenir.

 root@makine:/opt/malfs# ./lfs-mekanizma -cg
 
 root [ / ]#  export FORCE_UNSAFE_CONFIGURE=1
 
 root [ / ]#  cd /root

 root [ / ]#  ./lfs-mekanizma -td temel-ek
 
 en son bu mesaj ile derleme bitmelidir.
 
 =======>  'nano.tr#2.5.2-any.mps.xz' basarili sekilde kuruldu.
 
 başlatıcı(initram-initrd) oluşturulması
 
 root [ / ]#  ./lfs-mekanizma -bo

 temel-ek sistem paketlerin paket_depo altında toplanması-paketlerin arsivlenmesi

 root [ / ]#  paketleri_arsivle

 chroottan cıkılıp,son sistemin yedegi alınır.

 root [ / ]#  exit 
 
 root@makine:/opt/malfs# ./lfs-mekanizma -ss
 
 son sistemin yedeği alındıktan sonra iso yapımı için sırasıyla
 
 root@makine:/opt/malfs# ./lfs-mekanizma -so
 root@makine:/opt/malfs# ./lfs-mekanizma -io
 
 komutları verilir.çalışma dizini altında malfs.iso oluşacaktır.
 
 root@makine:/opt/malfs# qemu-system-x86_64 -m 512 malfs.iso
 
 komutuyla iso test edilebilir. 
 
 
 
