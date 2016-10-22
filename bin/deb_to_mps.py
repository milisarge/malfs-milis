#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import sys
os.system('rm -rf ~/.undeb/')
os.system('mkdir -p ~/.undeb/')
os.system('cp -pf ' + sys.argv[1] + ' ~/.undeb/undeb.deb')
os.system('cd ~/.undeb/ ; ar -x ~/.undeb/undeb.deb')
os.system('rm -f ~/.undeb/undeb.deb')
os.system('rm -f ~/.undeb/debian-binary')
os.system('mkdir ~/.undeb/data')
os.system('mv ~/.undeb/data.tar.* ~/.undeb/data/data.tar.*')
print "Deb çözülüyor..."
os.system('cd ~/.undeb/data ; tar -xf ~/.undeb/data/data.tar.*')
os.system('rm -f ~/.undeb/data/data.tar.*')
os.system('mkdir ~/.undeb/DEBIAN/')
os.system('mv ~/.undeb/control.tar.gz ~/.undeb/DEBIAN/control.tar.gz')
os.system('cd ~/.undeb/DEBIAN/ ; tar -xf ~/.undeb/DEBIAN/control.tar.gz')
os.system('rm -f ~/.undeb/DEBIAN/control.tar.gz')
#2. aşama liste oluşturma
os.system('cd ~/.undeb/data ; find > ~/.undeb/.MTREE')
os.system('sed -i "s|./||" ~/.undeb/.MTREE')
os.system('cp ~/.undeb/DEBIAN/postinst ~/.undeb/.POST')
control = open(os.environ["HOME"]+"/.undeb/DEBIAN/control")
veri = "\n"
while "\n" in veri:
  veri=control.readline()
  if "ackage:" in veri:
    data = veri.split(": ")
name=data[1].split("\n") 
os.system("mkdir -p ~/.undeb/talimatname/genel/"+ data[1])
os.system('echo > ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')

def oku(ozellik="",ek=""):
  veri = ": "
  name=data[1].split("\n")
  control = open(os.environ["HOME"]+"/.undeb/DEBIAN/control")
  while ": " in veri:
    veri=control.readline()
    if ozellik in veri:
      veri = veri.split(": ")
      veri2=veri[1].split("\n")
      if veri2[0] == "amd64":
	veri2[0] = "x86_64"
      if veri2[0] == "all":
	veri2[0] = "x86_64"
      if veri2[0] == "i386":
	veri2[0] = "x86_64"
      os.system('echo "' + ek + veri2[0] + '" >> ~/.undeb/.META') 

def talimat(ozellik="",ek="# "):
  veri = ": "
  name=data[1].split("\n")
  control = open(os.environ["HOME"]+"/.undeb/DEBIAN/control")
  while ": " in veri:
    veri=control.readline()
    if ozellik in veri:
      veri = veri.split(": ")
      veri2=veri[1].split("\n")
      os.system('echo "' + ek + veri2[0] + '" >> ~/.undeb/talimatname/genel/'+ name[0]+ '/talimat') 

oku("ackage:","N")
oku("escription:","D")
oku("omepage:","U")
os.system('echo "Mhttps://www.debian.org/" >> ~/.undeb/.META') 
os.system('echo "Pport debian package" >> ~/.undeb/.META') 
oku("nstalled-Size:","S")
oku("ersion:","V")
os.system('echo "r1" >> ~/.undeb/.META') 
os.system('echo "B1" >> ~/.undeb/.META') 
oku("rchitecture","a")
talimat("escription","# Description: ")
talimat("omepage","# URL:")
talimat("epends","# Depends on:")
os.system('echo "# Packager: Debian" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat') 
os.system('echo  >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat') 
talimat("ackage","name=")
talimat("ersion","version=")
os.system('echo  >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat') 
os.system('echo "release=1" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
os.system('echo "source=(http://localhost/)" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
os.system('echo "build()" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
os.system('echo "{" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
os.system('echo "exit" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
os.system('echo "}" >> ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
os.system('sed -i "s|(.*)||" ~/.undeb/talimatname/genel/'+ name[0] + '/talimat')
#talimat ve .META tamam. Şimdi paket zamanı
os.system('mkdir -p /root/talimatname/genel/'+ name[0])
os.system('cp -f ~/.undeb/talimatname/genel/'+ name[0] + '/talimat ./' + name[0] + '.talimat')
os.system('cp -f ~/.undeb/talimatname/genel/'+ name[0] + '/talimat /root/talimatname/genel/'+ name[0] + '/talimat')
os.system("rm -rf ~/.undeb/talimatname/")
os.system("rm -rf ~/.undeb/DEBIAN/")
os.system("mv -f ~/.undeb/data/* ~/.undeb/")
os.system("rm -rf ~/.undeb/data/")
os.system("clear")
print "MPS Paketleniyor."
os.system('cd ~/.undeb/ ; tar --lzip -cf ~/.undeb/' + name[0] + '.mps.lz ./* ./.META ./.MTREE')
print name[0] + " paketi ve talimat dosyası oluşturuldu..."
os.system('mv -f ~/.undeb/' + name[0] + '.mps.lz ./' + name[0] + '.mps.lz')
