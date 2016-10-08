#!/usr/bin/python3

# Milis Linux Konsol / Grafik Kurulum Betiği
# Not: Bu betik henüz tamamlanmış değil. 
# Commit tarihi: 25.09.2016 
# Dialog manuali için: http://pythondialog.sourceforge.net/doc/


from dialog import Dialog
import os,sys,re,subprocess,time
import crypt

d = Dialog(dialog="dialog")
f = open("/tmp/log.txt","w")

def runShellCommand(c):
	out = subprocess.check_output(c,stderr=subprocess.STDOUT,shell=True,universal_newlines=True)
	return out.replace("\b","")  #encode byte format to string, ugly hack 

def greetingDialog():
	status = d.yesno(title="Milis Linux'a hoş geldiniz !", 
	text="Tanıtım yazısı buraya gelecek...\n\n\n\nKuruluma devam etmek istiyor musunuz ?",width=70,height=10)
	if status == "ok":
		checkUsername()
	else:
		sys.exit()

def checkUsername():
	
	#status ok ya da cancel gibi durumları çekiyor. 
	status,username = d.inputbox(text="Lütfen kullanıcı adı giriniz")
	
	#NAME_REGEX bkz. man 5 adduser.conf
	if bool(re.compile(r'^[a-z][-a-z0-9]*$').match(username)):
		checkUserPassword(username)
	else:
		status=d.msgbox(text="Hatalı kullanıcı adı girdiniz.\n\n\
		Kullanıcı adları alfanümerik karakterle başlamalıdır\
		ve alfanümerik (A-Z), nümerik (0-9) ve tire (-) \
		harici bir karakter içermemelidir.",width=60)
		if status == "ok":
			checkUsername()


def createUser(name,username,password):
    encPass = crypt.crypt(password,"22")   
    return  os.system("useradd -p "+encPass+ " -s "+ "/bin/bash "+ "-d "+ "/home/" + username+ " -m "+ " -c \""+ name+"\" " + username)


def checkUserPassword(username):
	#insecure=True parolanın yıldız şeklinde gözükmesini sağlar, 
	#root şifresi sorarken belki bunu silebiliriz normal sudo şifresi 
	#girer gibi gözükmez. 
	status,password = d.passwordbox(text="Lütfen {} kullanıcısı için şifrenizi giriniz".format(username),insecure=True)
	if len(password) > 0:
		createUser(username,username,password)
		f.write("[+] Kullanıcı eklendi")
		d.infobox(text=username+" kullanıcısı başarıyla eklendi.")
		if d.yesno(text="Yeni kullanıcı eklemek istiyor musunuz ?") == "ok":
			checkUsername()
		else:
			chooseDisk()
	else:
		status=d.msgbox(text="Şifreniz boş olamaz")
		checkUserPassword(username)

def chooseDisk():
	diskChoice = []
	diskNames  = runShellCommand("lsblk -nS -o NAME").split('\n')
	diskModels = runShellCommand("lsblk -nS -o MODEL").split('\n')
	for i in range(len(diskNames)):
		diskChoice.append((diskNames[i],diskModels[i]))
	status,selectedDisk = d.menu(text="Lütfen bölümleme yapmak istediğiniz diski seçiniz:",choices=diskChoice)
	os.system("cfdisk /dev/" + selectedDisk)
	choosePart()

def choosePart():
	partChoice = []
	#Şimdilik Parted kütüphanesine gerek kalmadı, lsblk istediğimiz bütün değerleri alıyor.
	diskParts  = runShellCommand("lsblk -ln -o  NAME    | awk '{print $1}'").split('\n')
	partSizes  = runShellCommand("lsblk -ln -o  SIZE    | awk '{print $1}'").split('\n')
	partFs     = runShellCommand("lsblk -ln -o  FSTYPE  | awk '{print $1}'").split('\n')
	partMajmin = runShellCommand("lsblk -ln -o  MAJ:MIN | awk '{print $1}'").split('\n')
	partLabel  = runShellCommand("lsblk -ln -o  LABEL").split('\n') #Bunda awk yok çünkü arada boşluk olabilir. 
	for i in range(len(diskParts)-1):
		if partMajmin[i].split(":")[1] != "0": # partition olmayanları ele (sda/sdb seçince grub bozuluyor.)
			partChoice.append((diskParts[i],partLabel[i]+ "\t" +partSizes[i]+"\t"+partFs[i]))
	status,selectedPart = d.menu(text="Sistemin kurulacağı diski seçiniz",choices=partChoice)
	if status == "ok":
		f.write("{} seçildi !".format(selectedPart)) #burası da düzeltilcek şimdilik böyle commitliyorum :D
		print("{} seçildi !".format(selectedPart))
		formatDialog(selectedPart)
def formatDialog(part):
	status = d.yesno(title="Uyarı !", 
	text="/dev/{} bölümü ext4 türünde formatlanacak. Emin misiniz ?".format(part))	
	if status == "ok":
		d.infobox(text="Formatlanıyor... Lütfen bekleyiniz...")
		formatPart(part)
		time.sleep(5)
	else:
		choosePart() 
		
def formatPart(part):
	os.system("mkfs.ext4 "+"/dev/"+part)
	d.infobox(text="/dev/"+part+" Disk Formatlandı")
	chooseSwap()
	hedef="/dev/"+part
	hedefBagla(hedef)

def hedefBagla(hedef):
	os.system("umount /mnt && mount "+hedef+" /mnt")
	sistemKopyala()

def sistemKopyala():
	os.system("acp -g -axvnu /  /mnt")
	initrdOlustur()
	
def initrdOlustur():
	os.system("mount --bind /dev /mnt/dev")
	os.system("mount --bind /sys /mnt/sys")
	os.system("mount --bind /proc /mnt/proc")
	os.system('chroot /mnt dracut --no-hostonly --add-drivers "ahci" -f /boot/initramfs')
	if d.yesno(text="Grub kurmak istiyor musunuz ?") == "ok":
		grubKur()
	else:
		kurulumBitir()

def grubKur():
	os.system("grub-install --boot-directory=/mnt/boot /dev/sdb")
	os.system("grub-mkconfig -o /boot/grub/grub.cfg")
	kurulumBitir()
	
def kurulumBitir():
	d.infobox(text="milis işletim sistemi kuruldu.")
		
def chooseSwap():
	swapChoice = []
	#Şimdilik Parted kütüphanesine gerek kalmadı, lsblk istediğimiz bütün değerleri alıyor.
	diskParts  = runShellCommand("lsblk -ln -o  NAME    | awk '{print $1}'").split('\n')
	partSizes  = runShellCommand("lsblk -ln -o  SIZE    | awk '{print $1}'").split('\n')
	partFs     = runShellCommand("lsblk -ln -o  FSTYPE  | awk '{print $1}'").split('\n')
	partMajmin = runShellCommand("lsblk -ln -o  MAJ:MIN | awk '{print $1}'").split('\n')
	partLabel  = runShellCommand("lsblk -ln -o  LABEL").split('\n') #Bunda awk yok çünkü arada boşluk olabilir. 
	for i in range(len(diskParts)-1):
		if partMajmin[i].split(":")[1] != "0": # partition olmayanları ele (sda/sdb seçince grub bozuluyor.)
			swapChoice.append((diskParts[i],partLabel[i]+ "\t" +partSizes[i]+"\t"+partFs[i]))
	status,selectedPart = d.menu(text="Takas alanının yer alacağı disk bölümünü seçiniz",choices=swapChoice)
	if status == "ok":
		f.write("{} seçildi !".format(selectedPart)) #burası da düzeltilcek şimdilik böyle commitliyorum :D
		print("{} seçildi !".format(selectedPart))		
		setSwap(selectedPart)
		
def setSwap(part):
	os.system("swapon "+"/dev/"+part)
	
		 
if __name__ == "__main__":
	greetingDialog()
