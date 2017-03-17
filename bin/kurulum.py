#!/usr/bin/python3
# Milis Linux Konsol / Grafik Kurulum Betiği 
# Commit tarihi: 25.09.2016-03.2017
# Dialog rehberi için: http://pythondialog.sourceforge.net/doc/
# Yazarlar: milisarge,geekdinazor

import sys
import subprocess
import re
import crypt
import os
import time
import sys
import site
import json

kontrol=True

if kontrol: 
	#talimatname-paket güncellemeleri
	os.system("clear")
	os.system("mps -GG")
	os.system("mps -G")

	#lsb-release tamiri
	os.system("mps -g lsb-release")

	#gereklerin kontrolü-kurulumu
	paketd=site.getsitepackages()
	yukluler=os.listdir(paketd[0])
	mps_gerekler="/tmp/komutan.gerekler"
	kur="pip3 install "
	mpskur="mps kur "
	kontrol=[""]
	mpskontrol=["python3-pip","python-yaml","python3-yaml","python3-pythondialog"]

	for mpsk in mpskontrol:
		if os.path.exists("/var/lib/pkg/DB/"+mpsk) is False:
			os.system("mps kur "+mpsk)
		else:
			print(mpsk,"zaten kurulu")
			
	for yuklu in yukluler:
		for kont in kontrol:
			if kont in yuklu:
				print (kont,"kurulu")
				kontrol.remove(kont)
	for kont in kontrol:
		os.system(kur+kont)	


from dialog import Dialog
import yaml

d = Dialog(dialog="dialog")
f = open("/tmp/kurulum.log","w")

_kurulum_dosya="/root/ayarlar/kurulum.yml"
kurulum_dosya=""

if not os.path.exists(_kurulum_dosya):
	d.infobox(text=_kurulum_dosya+" bulunamadı!")
	sys.exit()
else:
	os.system("cp "+_kurulum_dosya+" /opt/kurulum.yml")
	kurulum_dosya="/opt/kurulum.yml"

def komutCalistir(c):
	out = subprocess.check_output(c,stderr=subprocess.STDOUT,shell=True,universal_newlines=True)
	return out.replace("\b","")  #byte-string çevrim 

def kurulum_oku(kurulumdos):
	with open(kurulumdos, 'r') as f:
		param = yaml.load(f)
	return param

def kurulum_yaz(param,kurulumdos):
	with open(kurulumdos, 'w') as outfile:
		yaml.dump(param, outfile, default_flow_style=False,allow_unicode=True)	

def paramEkran(param,indent=0):
	yazi=""
	'''for key, value in param.iteritems():
		yazi+='\t' * indent + str(key)+"\n"
		if isinstance(value, dict):
			paramEkran(value, indent+1)
		else:
			yazi+='\t' * (indent+1) + str(value)
	return yazi
	'''
	return json.dumps(param,sort_keys=True, indent=4)
	
kurparam=kurulum_oku(kurulum_dosya)

def karsilamaEkrani():
	status = d.yesno(title="Milis Linux Atilla 1.0 Kurulum Ekranı", 
	text="Milis Linux (Milli İşletim Sistemi) sıfır kaynak koddan üretilen,kendine has paket yöneticisine sahip,\
	bağımsız tabanlı yerli linux işletim sistemi projesidir.\
	Genel felsefe olarak ülkemizdeki bilgisayar kullanıcıları için linuxu kolaylaştırıp\
	Milis işletim sisteminin sorunsuz bir işletim sistemi olmasını sağlamayı ve yazılımsal\
	olarak dışa bağımlı olmaktan kurtarmayı esas alır. Ayrıca her türlü katkıda bulunmak\
	isteyenler için bulunmaz bir türkçe açık kaynak projesidir.\
	\n\n\nKuruluma devam etmek istiyor musunuz ?",width=80,height=12)
	if status == "ok":
		kullaniciKontrol()
	else:
		sys.exit()

def kullaniciKontrol():
	
	#status ok ya da cancel gibi durumları çekiyor. 
	status,kullisim = d.inputbox(text="Lütfen kullanıcı adı giriniz")
	
	#NAME_REGEX bkz. man 5 adduser.conf
	if bool(re.compile(r'^[a-z][-a-z0-9]*$').match(kullisim)):
		sifreKontrol(kullisim)
	else:
		status=d.msgbox(text="Hatalı kullanıcı adı girdiniz.\n\n\
		Kullanıcı adları alfanümerik karakterle başlamalıdır\
		ve alfanümerik (A-Z), nümerik (0-9) ve tire (-) \
		harici bir karakter içermemelidir.",width=60)
		if status == "ok":
			kullaniciKontrol()

def kullaniciTanimla(isim,kullisim,kullsifre):
    #encPass = crypt.crypt(kullsifre,"22")   
    #os.system("useradd -p "+encPass+ " -s "+ "/bin/bash "+ "-d "+ "/home/" + kullisim+ " -m "+ " -c \""+ name+"\" " + kullisim)
	kurparam["kullanici"]["isim"]=kullisim
	kurparam["kullanici"]["sifre"]=kullsifre
	###os.system("kopar milis-"+isim+" "+kullisim)
	###os.system('echo -e "'+kullsifre+'\n'+kullsifre+'" | passwd '+kullisim)

def kullaniciOlustur(isim,kullisim,kullsifre):
    #encPass = crypt.crypt(kullsifre,"22")   
    #os.system("useradd -p "+encPass+ " -s "+ "/bin/bash "+ "-d "+ "/home/" + kullisim+ " -m "+ " -c \""+ name+"\" " + kullisim)
	os.system("kopar milislinux-"+isim+" "+kullisim)
	os.system('echo -e "'+kullsifre+'\n'+kullsifre+'" | passwd '+kullisim)
	#masaustu ve diğer ayarların aktarılması
	ayar_komut="cp -r /root/.config /home/"+kullisim+"/"
	os.system(ayar_komut)
	saat_komut="saat_ayarla_tr"
	os.system(saat_komut)
	d.infobox(text=kullisim+" kullanıcısı başarıyla oluşturuldu.")
	time.sleep(1)

def sifreKontrol(kullisim):
	#insecure=True parolanın yıldız şeklinde gözükmesini sağlar, 
	#root şifresi sorarken belki bunu silebiliriz normal sudo şifresi 
	#girer gibi gözükmez. 
	status,kullsifre = d.passwordbox(text="Lütfen {} kullanıcısı için şifrenizi giriniz".format(kullisim),insecure=True)
	if len(kullsifre) > 0:
		kullaniciTanimla(kullisim,kullisim,kullsifre)
		d.infobox(text=kullisim+" kullanıcısı başarıyla tanımlandı.")
		time.sleep(1)
		bolumSec()
	else:
		status=d.msgbox(text="Şifreniz boş olamaz")
		sifreKontrol(kullisim)

def diskSecim():
	diskSecimler = []
	diskIsımler  = komutCalistir("lsblk -nS -o NAME").split('\n')
	diskModeller = komutCalistir("lsblk -nS -o MODEL").split('\n')
	for i in range(len(diskIsımler)):
		diskSecimler.append((diskIsımler[i],diskModeller[i]))
	status,seciliDisk = d.menu(text="Lütfen bölümleme yapmak istediğiniz diski seçiniz:",choices=diskSecimler)
	###os.system("cfdisk /dev/" + seciliDisk)
	bolumSec()

def bolumSec():
	bolumSecimler = []
	uygunBolumler = ['sd','hd','mmcblk0p']
	#Şimdilik Parted kütüphanesine gerek kalmadı, lsblk istediğimiz bütün değerleri alıyor.
	diskBolumler  = komutCalistir("lsblk -ln -o  NAME    | awk '{print $1}'").split('\n')
	bolumBoyutlar  = komutCalistir("lsblk -ln -o  SIZE    | awk '{print $1}'").split('\n')
	bolumDs     = komutCalistir("lsblk -ln -o  FSTYPE  | awk '{print $1}'").split('\n')
	bolumMajmin = komutCalistir("lsblk -ln -o  MAJ:MIN | awk '{print $1}'").split('\n')
	bolumEtiket  = komutCalistir("lsblk -ln -o  LABEL").split('\n') #Bunda awk yok çünkü arada boşluk olabilir. 
	for i in range(len(diskBolumler)-1):
		if bolumMajmin[i].split(":")[1] != "0": # partition olmayanları ele (sda/sdb seçince grub bozuluyor.)
			for uygunBolum in uygunBolumler:
				if uygunBolum in diskBolumler[i]: 
					if bolumDs[i] == "ext4":
						bolumSecimler.append((diskBolumler[i],bolumEtiket[i]+ "\t" +bolumBoyutlar[i]+"\t"+bolumDs[i]))
	status,seciliBolum = d.menu(text="Sistemin kurulacağı diski seçiniz",choices=bolumSecimler)
	if status == "ok":
		print("{} seçildi !".format(seciliBolum))
		kurparam["disk"]["bolum"]="/dev/"+seciliBolum
		formatDialog(seciliBolum)
		
def formatDialog(part):
	status = d.yesno(title="Uyarı !", 
	text="/dev/{} bölümü ext4 türünde formatlanacak. Emin misiniz ?".format(part))	
	if status == "ok":
		kurparam["disk"]["format"]="evet"
	else:
		kurparam["disk"]["format"]="hayir"
	takasSec(part)
		
def bolumFormatla(hedef):
	komut="umount -l "+hedef
	print (komut)
	if os.path.exists(hedef):
		os.system(komut)
		komut2="mkfs.ext4 -F " + hedef
		try:
			os.system(komut2)
		except OSError as e:
			d.infobox(text=str(e))
			time.sleep(1)
			sys.exit()
		d.infobox(text=hedef+" disk bölümü formatlandı.")
		time.sleep(1)
	else:
		d.infobox(text="disk bölümü bulunamadı!")
		time.sleep(1)
		sys.exit()
		
def bolumBagla(hedef,baglam):
	komut="mount "+hedef+" "+baglam
	try:
		os.system(komut)
	except OSError as e:
		d.infobox(text=str(e))
		time.sleep(1)
		sys.exit()
		
	d.infobox(text=hedef+" "+baglam+" altına bağlandı.")
	time.sleep(1)

def bolumCoz(hedef):
	komut="umount -l "+hedef
	try:
		os.system(komut)
	except OSError as e:
		d.infobox(text=str(e))
		time.sleep(1)
		sys.exit()
		
	d.infobox(text=hedef+" çözüldü.")
	time.sleep(1)

def sistemKopyala(baglam):
	os.system("clear")
	komut=""
	#bazı dizinleri atlamak için ve hız rsync
	dizinler=["bin","boot","home","lib","sources","usr","depo","etc","include","lib64","opt","root","sbin","var"]
	yenidizinler=["srv","proc","tmp","mnt","sys","run","dev","media"]
	i=0
	mikdiz=len(dizinler)
	for dizin in dizinler:
		i+=1
		print (i,"/",mikdiz,dizin,"kopyalanıyor.....")
		komut="rsync --delete -a --info=progress2 /"+dizin+" "+baglam+" --exclude /proc"
		print (dizin,"kopyalandı.")
		os.system(komut)
	for ydizin in yenidizinler:
		print (ydizin,"oluşturuluyor.....")
		komut="mkdir -p "+baglam+"/"+ydizin
		os.system(komut)
		print (ydizin,"oluşturuldu.")
	#yükleme akışı için acp
	#os.system("acp -g -axnu / "+baglam)
	#normal cp
	#os.system("cp -axvnu /  "+baglam)
	
	d.infobox(text="sistem kopyalandı.")
	time.sleep(1)
	
def initrdOlustur(hedef):
	os.system("mount --bind /dev "+hedef+"/dev")
	os.system("mount --bind /sys "+hedef+"/sys")
	os.system("mount --bind /proc "+hedef+"/proc")
	os.system('chroot '+hedef+' dracut --no-hostonly --add-drivers "ahci" -f /boot/initramfs')
	
	d.infobox(text="initrd kuruldu.")
	time.sleep(1)

def grubKurTespit():
	if d.yesno(text="Grub kurmak istiyor musunuz ?") == "ok":
		kurparam["grub"]["kur"]="evet"
	else:
		kurparam["grub"]["kur"]="hayir"
	kurulumBilgi()
		
def kurulumBilgi():
	kurulum_yaz(kurparam,kurulum_dosya)
	d.infobox(text="Kurulum ayarlarınız başarıyla kayıt edildi.")	
	time.sleep(1)	
	kurulumUygula(kurulum_dosya)

def grubKur(hedef,baglam):
	hedef = hedef[:-1]
	if hedef == "/dev/mmcblk0": #SD kart'a kurulum fix
		os.system("grub-install --boot-directory="+baglam+"/boot /dev/mmcblk0")
	else:
		os.system("grub-install --boot-directory="+baglam+"/boot " + hedef)
	os.system("chroot "+baglam+" grub-mkconfig -o /boot/grub/grub.cfg")
	
	d.infobox(text="grub kuruldu.")
	time.sleep(1)

def kurulumUygula(dosya):
	#ayarların alınması
	kurulum=kurulum_oku(dosya)
	yazi=""
	yazi+=paramEkran(kurulum)+"\n\n"
	yazi+="Kurulum Ayarlarını onaylıyor musunuz?"
	if d.yesno(text=yazi,width=50,height=70) == "ok":
		#kurulum işlemi
		kbolum=kurulum["disk"]["bolum"]
		kformat=kurulum["disk"]["format"]
		kbaglam=kurulum["disk"]["baglam"]
		ktakas=kurulum["disk"]["takasbolum"]
		kisim=kurulum["kullanici"]["isim"]
		ksifre=kurulum["kullanici"]["sifre"]
		kgrubkur=kurulum["grub"]["kur"]
		#ayarların uygulanması
		#formatlama
		if kformat == "evet":
			bolumFormatla(kbolum)
		if ktakas !="":
			takasAyarla(ktakas)
		#kurulacak bölümün bağlanması
		bolumBagla(kbolum,kbaglam)
		#kullanıcı oluşturma
		kullaniciOlustur(kisim,kisim,ksifre)
		#sistemin kopyalanması
		sistemKopyala(kbaglam)
		#initrd oluşturulması
		initrdOlustur(kbaglam)
		#grub kurulması
		if kgrubkur == "evet":
			grubKur(kbolum,kbaglam)
		bolumCoz(kbolum)
		d.infobox(text="Milis İşletim Sistemi başarıyla kuruldu.")
	else:
		if d.yesno(text="Kurulumdan Çıkış?") == "ok":
			sys.exit() 
		else:
			karsilamaEkrani()	
		
def takasSec(kbolum):
	if d.yesno(text="Takas alanı kullanmak istiyor musunuz ?") == "ok":
		takasSecimler = []
		uygunBolumler = ['sd','hd','mmcblk0p']
		#Şimdilik Parted kütüphanesine gerek kalmadı, lsblk istediğimiz bütün değerleri alıyor.
		diskBolumler  = komutCalistir("lsblk -ln -o  NAME    | awk '{print $1}'").split('\n')
		bolumBoyutlar  = komutCalistir("lsblk -ln -o  SIZE    | awk '{print $1}'").split('\n')
		bolumDs     = komutCalistir("lsblk -ln -o  FSTYPE  | awk '{print $1}'").split('\n')
		bolumMajmin = komutCalistir("lsblk -ln -o  MAJ:MIN | awk '{print $1}'").split('\n')
		bolumEtiket  = komutCalistir("lsblk -ln -o  LABEL").split('\n') #Bunda awk yok çünkü arada boşluk olabilir. 
		for i in range(len(diskBolumler)-1):
			if bolumMajmin[i].split(":")[1] != "0": # partition olmayanları ele (sda/sdb swap için uygun değil)
				if diskBolumler[i] != kbolum:
					for uygunBolum in uygunBolumler: 
						if uygunBolum in diskBolumler[i]: #loop partlar gibi swap kurulamayacak alanları ele
							if bolumDs[i] == "swap":
								takasSecimler.append((diskBolumler[i],bolumEtiket[i]+ "\t" +bolumBoyutlar[i]+"\t"+bolumDs[i]))
		status,seciliBolum = d.menu(text="Takas alanının yer alacağı disk bölümünü seçiniz",choices=takasSecimler)
		if status == "ok":
			print("{} seçildi !".format(seciliBolum))		
			kurparam["disk"]["takasbolum"]="/dev/"+seciliBolum
	else:
		kurparam["disk"]["takasbolum"]=""
	grubKurTespit()
		
def takasAyarla(bolum):
	os.system("mkswap "+"/dev/"+bolum)
	os.system('echo "`lsblk -ln -o UUID /dev/' + bolum + '` none swap sw 0 0" | tee -a /etc/fstab')

def main():
	if len(sys.argv) == 1:
		karsilamaEkrani()
	else:
		dosya=sys.argv[1]
		if os.path.exists(dosya):
			kurulumUygula(dosya)
		else:
			d.infobox(text=dosya+" bulunamadı!")
			time.sleep(1)

		 
if __name__ == "__main__":
	
	main()

	
