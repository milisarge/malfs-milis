#!/bin/bash
#Milis-Linux kurulum yardımcısı
umount /mnt
clear
echo "Milis Linux Kurulumu"
echo ""
echo "Yeni kullanıcı adını giriniz:"
read user
useradd $user
passwd $user
clear
echo "Milis Linux Kurulumu"
echo ""
echo "hangi diske kurulum yapacaksınız:"
ls /dev/sd*
read disk
clear
echo "Milis Linux Kurulumu"
echo ""
echo "Grubu nereye kuracaksınız:"
ls /dev/sd*
read grub
clear
echo "Milis Linux Kurulumu"
echo ""
echo "Kurulum başlıyor"
mkfs.ext4 /dev/$disk 
mount $disk /mnt 
echo "Dosyalar Kopyalanıyor"
cp -axvnu /  /mnt 
echo "Kernel ayarları yapılıyor"
chroot /mnt dracut --no-hostonly --add-drivers "ahci" -f /boot/initramfs 
echo "Grub ayarlanıyor"
grub-install --boot-directory=/mnt/boot /$grub 
grub-mkconfig -o /mnt/boot/grub/grub.cfg 
clear
echo "Milis Linux Kurulumu"
echo ""
clear
echo "Milis kuruldu bilgisayarınızı yeniden başlatınız..."
