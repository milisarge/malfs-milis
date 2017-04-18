#!/usr/bin/python2
# -*- coding: utf-8 -*-
#
# Copyright (c) 2017 Mahmut Şamil Avar - milisarge
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

"""
Milis Linux Python Talimat Kütüphanesi - talimat.py
"""

import sys
import re
import os
import shlex
import urllib2
from requests.exceptions import HTTPError

# Milis linux talimat sınıfı
class Talimat():
	
	talimatname="/sources/milis.git/talimatname/"
	
	def __init__(self):
		self.tanim=""
		self.url=""
		self.paketci=""
		self.gerekler=[]
		self.isim=""
		self._isim=""
		self.surum=""
		self.devir=""
		self.kaynaklar=[]
		self.derleme="build() {"+"\n"
	
	def ice_aktar(self,dosya,tip):
		if tip=="arch":
			pkgbuild=PKGBUILD(dosya)
			self.tanim=pkgbuild.description
			self.url=pkgbuild.url
			self.paketci="milisarge"
			if hasattr(pkgbuild, 'makedepends'):
				for mgerek in pkgbuild.makedepends:
					if mgerek not in self.gerekler:
						self.gerekler.append(mgerek)
			if hasattr(pkgbuild, 'depends'):
				for gerek in pkgbuild.depends:
					if gerek not in self.gerekler:
						self.gerekler.append(gerek)
			self.isim=pkgbuild.name
			if hasattr(pkgbuild, '_name'):
				self._isim=pkgbuild._name
			self.surum=pkgbuild.version
			self.devir=pkgbuild.release
			self.kaynaklar=pkgbuild.sources
			self._ice_aktar_bloklar(dosya,tip)
		return "tanımlar için gecersiz tip!"
		
	def _gerekler(self):
		gerekstr=""
		for gerek in self.gerekler:
			if os.path.exists(self.talimatname+"temel-ek/"+gerek) is False and os.path.exists(self.talimatname+"temel/"+gerek) is False:
				gerekstr+=gerek+" "
				if os.path.exists(self.talimatname+"genel/"+gerek) is False:
					print renk.uyari+gerek+" talimatı yapılmalı!"+renk.son
		return gerekstr
		
	def _kaynaklar(self):
		kaynakstr=""
		for kaynak in self.kaynaklar:
			kaynakstr+=kaynak+"\n"
		return kaynakstr
		
	def _ice_aktar_bloklar(self,dosya,tip):
		if tip=="arch":
			#bu sekilde de satirlar cekilebilir.
			#lines = [line.rstrip('\n') for line in open(dosya)]
			with open(dosya) as f:
				satirlar = f.readlines()
			blok=False
			onblok=False
			for satir in satirlar:
				if "md5sums=(" in satir  or "sha256sums=('" in satir:
					onblok=True
				if onblok is True and "')" in satir:
					blok=True
					continue
				if blok and satir.rstrip()!="" and satir.rstrip()!="}":
					if (satir not in self.derleme) and ("pkgver()" not in satir) and ("prepare()" not in satir) and ("build()" not in satir) and ("package()" not in satir):
						satir=satir.replace("pkgdir","PKG")
						satir=satir.replace("srcdir","SRC")
						satir=satir.replace("pkgname","name")
						satir=satir.replace("pkgver","version")
						satir=satir.replace("pkgrel","release")
						self.derleme+=satir+"\n"
		else:
			return "blok için gecersiz tip!"
	
	def olustur(self):
		if self.isim:
			print renk.tamamb+self.isim+" talimatı hazırlanıyor..."+renk.son
			os.system("mkdir -p "+self.isim)
			open(self.isim+"/talimat","w").write(self.icerik())
	
	def icerik(self):
		icerikstr=""
		icerikstr+="# Description: "+self.tanim+"\n"
		icerikstr+="# URL: "+self.url+"\n"
		icerikstr+="# Packager: "+self.paketci+"\n"
		icerikstr+="# Depends on: "+self._gerekler()
		icerikstr+="\n"+"\n"
		icerikstr+="name="+self.isim+"\n"
		if self._isim !="":
			icerikstr+="_name="+self._isim+"\n"
		icerikstr+="version="+str(self.surum)+"\n"
		icerikstr+="release="+str(self.devir)+"\n"
		icerikstr+="source=("+self._kaynaklar()+")"
		icerikstr+="\n"+"\n"
		icerikstr+=self.derleme
		icerikstr+="}"
		return icerikstr
		
	def cevir(self,dosya,tip="arch"):
		self.ice_aktar(dosya,tip)
		self.olustur()
		print renk.tamamy+talimat.isim+" talimatı hazır."+renk.son
		

# archlinux pkgbuild sınıfı
#Copyright (c) 2009 Sebastian Nowicki (parched.py)
class PKGBUILD():
	
    _symbol_regex = re.compile(r"\$(?P<name>{[\w\d_]+}|[\w\d]+)")

    def __init__(self, name=None, fileobj=None):
        self.install = ""
        self.checksums = {
            'md5': [],
            'sha1': [],
            'sha256': [],
            'sha384': [],
            'sha512': [],
        }
        self.noextract = []
        self.sources = []
        self.makedepends = []

        # Symbol lookup table
        self._var_map = {
            'pkgname': 'name',
            '_pkgname': '_name',
            'pkgver': 'version',
            'pkgdesc': 'description',
            'pkgrel': 'release',
            'source': 'sources',
            'arch': 'architectures',
            'license': 'licenses',
        }
        self._checksum_fields = (
            'md5sums',
            'sha1sums',
            'sha256sums',
            'sha384sums',
            'sha512sums',
        )
        # Symbol table
        self._symbols = {}

        if not name and not fileobj:
            raise ValueError("nothing to open")
        should_close = False
        if not fileobj:
            fileobj = open(name, "r")
            should_close = True
        self._parse(fileobj)
        if should_close:
            fileobj.close()

    def _handle_assign(self, token):
        var, equals, value = token.strip().partition('=')
        # Is it an array?
        if value[0] == '(' and value[-1] == ')':
            self._symbols[var] = self._clean_array(value)
        else:
            self._symbols[var] = self._clean(value)

    def _parse(self, fileobj):
        """Parse PKGBUILD"""
        if hasattr(fileobj, "seek"):
            fileobj.seek(0)
        parser = shlex.shlex(fileobj, posix=True)
        parser.whitespace_split = True
        in_function = False
        while 1:
            token = parser.get_token()
            
            if token is None or token == '':
                break
            # Skip escaped newlines and functions
            if token == '\n' or in_function:
                continue
            # Special case:
            # Array elements are dispersed among tokens, we have to join
            # them first
            if token.find("=(") >= 0 and not token.rfind(")") >= 0:
                in_array = True
                elements = []
                while in_array:
                    _token = parser.get_token()
                    if _token == '\n':
                        continue
                    if _token[-1] == ')':
                        _token = '"%s")' % _token.strip(')')
                        token = token.replace('=(', '=("', 1) + '"'
                        token = " ".join((token, " ".join(elements), _token))
                        in_array = False
                    else:
                        elements.append('"%s"' % _token.strip())
            # Assignment
            if re.match(r"^[\w\d_]+=", token):
                self._handle_assign(token)
            # Function definitions
            elif token == '{':
                in_function = True
            elif token == '}' and in_function:
                in_function = False
        self._substitute()
        self._assign_local()
        if self.release:
            self.release = float(self.release)

    def _clean(self, value):
        """Pythonize a bash string"""
        return " ".join(shlex.split(value))

    def _clean_array(self, value):
        """Pythonize a bash array"""
        return shlex.split(value.strip('()'))

    def _replace_symbol(self, matchobj):
        """Replace a regex-matched variable with its value"""
        symbol = matchobj.group('name').strip("{}")
        # If the symbol isn't found fallback to an empty string, like bash
        try:
            value = self._symbols[symbol]
        except KeyError:
            value = ''
        # BUG: Might result in an infinite loop, oops!
        return self._symbol_regex.sub(self._replace_symbol, value)

    def _substitute(self):
        """Substitute all bash variables within values with their values"""
        for symbol in self._symbols:
            value = self._symbols[symbol]
            # FIXME: This is icky
            if isinstance(value, str):
                result = self._symbol_regex.sub(self._replace_symbol, value)
            else:
                result = [self._symbol_regex.sub(self._replace_symbol, x)
                    for x in value]
            self._symbols[symbol] = result

    def _assign_local(self):
        """Assign values from _symbols to PKGBUILD variables"""
        for var in self._symbols:
            value = self._symbols[var]
            if var in self._checksum_fields:
                key = var.replace('sums', '')
                self.checksums[key] = value
            else:
                if var in self._var_map:
                    var = self._var_map[var]
                setattr(self, var, value)

class renk:
    baslik = '\033[95m'
    tamamb = '\033[94m'
    tamamy = '\033[92m'
    uyari = '\033[93m'
    hata = '\033[91m'
    son = '\033[0m'
    kalin = '\033[1m'
    altcizgili = '\033[4m'


class Arge:
	
	def indir(self,link):
		if "packages/" in link:
			paket=link.split("?h=packages/")[1]
		else:
			paket=link.split("?h=")[1]
		print renk.tamamb+paket+" indiriliyor..."+renk.son
		try:
			veri = urllib2.urlopen(link)
			open(paket+"_pkgbuild","w").write(veri.read())
			return paket+"_pkgbuild"
		except urllib2.HTTPError, e:
			if e.code == 404:
				print renk.hata+link+" bulunamadı!"+renk.son
				return None
				
	def aur_link(self,paket):
		link="https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h="+paket
		return link
		
	def arch_link(self,paket):
		link="https://git.archlinux.org/svntogit/community.git/plain/trunk/PKGBUILD?h=packages/"+paket
		return link	
		
if __name__ == '__main__':
	
	if len(sys.argv) > 1:
		dosya=sys.argv[1]
		talimat=Talimat()
		arge=Arge()
		if os.path.exists(dosya):
			talimat.cevir(dosya)
		elif "https" in dosya or "http" in dosya:
			Pdosya=arge.indir(dosya)
			talimat.cevir(Pdosya)
		elif dosya == "-a":
			if len(sys.argv) > 2:
				paket=sys.argv[2]
				paket=str(paket)
				link=arge.aur_link(paket)
				dosya=arge.indir(link)
				if dosya is None:
					link=arge.arch_link(paket)
					dosya=arge.indir(link)
				if link and dosya:
					talimat.cevir(dosya)	
		else:
			print renk.hata+dosya+" paremetre bulunamadı!"+renk.son
