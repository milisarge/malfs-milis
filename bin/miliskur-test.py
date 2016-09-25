# Milis Linux Konsol / Grafik Kurulum Betiği
# Not: Bu betik henüz tamamlanmış değil. 
# Commit tarihi: 25.09.2016 
# Dialog manuali için: http://pythondialog.sourceforge.net/doc/


from dialog import Dialog
import re,sys,subprocess

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
	#NAME_REGEX bkz. man 5 adduser.conf
	pattern = re.compile("/^([A-Z][0-9]+)*$/")
	
	#status ok ya da cancel gibi durumları çekiyor. 
	status,username = d.inputbox(text="Lütfen kullanıcı adı giriniz")

	if bool(re.compile(r'^[a-z][-a-z0-9]*$').match(username)):
		checkUserPassword(username)
	else:
		status=d.msgbox(text="Hatalı kullanıcı adı girdiniz.\n\n\
		Kullanıcı adları alfanümerik karakterle başlamalıdır\
		ve alfanümerik (A-Z), nümerik (0-9) ve tire (-) \
		harici bir karakter içermemelidir.",width=60)
		if status == "ok":
			checkUsername()

def checkUserPassword(username):
	#insecure=True parolanın yıldız şeklinde gözükmesini sağlar, 
	#root şifresi sorarken belki bunu silebiliriz normal sudo şifresi 
	#girer gibi gözükmez. 
	status,password = d.passwordbox(text="Lütfen {} kullanıcısı için şifrenizi giriniz".format(username),insecure=True)
	if len(password) > 0:
		#buraya kullanıcı ekleme kodu eklenecek. Şuan kendi sistemimde yazıyorum sıkıntı çıkmasın diye implemente etmedim. 
		f.write("[+] Kullanıcı eklendi")
		if d.yesno(text="Yeni kullanıcı eklemek istiyor musunuz ?") == "ok":
			checkUsername()
		else:
			chooseDisk()
		
		
	else:
		status=d.msgbox(text="Şifreniz boş olamaz")
		checkUserPassword(username)

def chooseDisk():
	choice = []
	#Burayı parted kütüphanesi ile yapmayı düşünüyorum. (Partition title, boyut ve dosya türünü de gösterecek)
	diskParts = runShellCommand("cat /proc/partitions | awk '{print $NF}'|\
	 sed s'/name//g;'/^\s*$/d''| sed '/[0-9]/!d'")
	diskParts = diskParts.split('\n')
	for partition in diskParts:
		choice.append((partition,partition))
	status,selectedPart = d.menu(text="Sistemin kurulacağı diski seçiniz",choices=choice)
	if status == "ok":
		f.write("{} seçildi !".format(selectedPart)) #burası da düzeltilcek şimdilik böyle commitliyorum :D
		print("{} seçildi !".format(selectedPart))
		 
	
greetingDialog()
