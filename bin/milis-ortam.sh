#!/bin/bash

# değişkenler - yolların iyi ayarlandığından emin olunuz.
 
lfs=/mnt/lfs
rootfs=/mnt/rootfs
ikincil=/mnt/ikincil
kaynaklar=/mnt/sources
ortam=/mnt/reposuz-milis-bootstrap-enson.sfs

[ ! -f $ortam ] && exit 1

# herhangi bir hatada çıkış yap
set -e

ortam_bagla(){
	mkdir -p $rootfs
	mkdir -p $lfs
	mkdir -p $ikincil
	mount -t squashfs -o loop $ortam $rootfs/
	mount -t tmpfs -o size=3072M,mode=0744 tmpfs $ikincil/
	mount -t aufs -o br=$ikincil=rw:$rootfs=ro none $lfs/ 
	mkdir -p $lfs/sources
	mount -t aufs -o br=$kaynaklar=rw none $lfs/sources/
}

ortam_coz()
{
    # umount -l /mnt/rootfs;umount -l /mnt/ikincil;umount -l /mnt/lfs
    for node in "${lfs}" \
                "${ikincil}" \
                "${rootfs}" \
                "${lfs}/sys" \
                "${lfs}/proc" \
                "${lfs}/dev/pts" \
                "${lfs}/dev" ; \
    do
        if mount | grep -q "$node"
        then
            echo "çözülüyor ${node} ..."
            if ! umount "$node"
            then
                echo "sıkıntılı $node çözülüyor..."
                umount -l "$node"
            fi
        fi
    done
}

ortam_bagla_son(){
	cp -v /etc/resolv.conf $lfs/etc
	# ana sistemin mps ayarlarını kullanmak için
	cp -f -v /etc/mps.conf $lfs/etc
	cp -f -v /etc/mpsd.conf $lfs/etc
	mount -v -B /dev $lfs/dev
	#mount -vt devpts devpts $lfs/dev/pts -o gid=5,mode=620
	#mount -vt devpts devpts $lfs/dev/pts
	# make hatası düzeliyor-segm fault
	mount --bind /dev/pts $lfs/dev/pts
	mount -vt proc proc $lfs/proc
	#bazı durumlarda bu kullanılacak tty değilde pty i kullanan derlemelerde
	#mount --bind /dev/pts $lfs/dev/pts
	mount -vt sysfs sysfs $lfs/sys
	#if [ -h /dev/shm ]; then rm -f $lfs/dev/shm;mkdir $lfs/dev/shm;fi
	#mount -vt tmpfs shm $lfs/dev/shm
	#chmod 1777 /dev/shm
}

# gerekli bağlamaların yapılmasından sonra ortama giriş-chroot
ortam_gir(){
	ortam_bagla_son
	[ -f "/sources/milis.git/ayarlar/bashrc_chroot" ] && cp "/sources/milis.git/ayarlar/bashrc_chroot" "$lfs"/etc/bashrc
	chroot  "$lfs" /usr/bin/env -i HOME=/root TERM="$TERM" PS1='\u:\w\$ ' /bin/bash --login
	#chroot "$lfs" /usr/bin/env -i HOME=/root PS1='\u:\w\$ ' /bin/bash --login +h
}

# ortam ayarlamalarından önce eski bağların çözülmesi
ortam_coz

# aufs modülünün kontrolü ve yüklenmesi
if lsmod | grep "aufs" &> /dev/null ; then
	ortam_bagla
	echo "Milis paket üretim ortamı bağlandı."
else
	modprobe aufs
	echo "aufs modülü yüklendi."
	if lsmod | grep "aufs" &> /dev/null ; then
		ortam_bagla
	else
		echo "aufs modülü bulunamadı!"
		exit 1
	fi
fi

# çıkarken bağların çözülmesi için trap-yakalama noktası ekleriz
trap 'echo ; ortam_coz' EXIT HUP QUIT ABRT TERM

# ortama giriş
ortam_gir
