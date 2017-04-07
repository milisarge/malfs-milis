#!/bin/bash

#butun ld.conf dizinlerini gezmek icin
#for dizin in `ldconfig -v | grep -v ^$'\t'`
#do
#	echo $dizin | grep -v '^/'
#done
for sodosya in `ls /usr/bin/*`
do	
	if [[ $(milis-ldd -d $sodosya | grep not\ found) ]] ;then 
		echo $sodosya 
	fi
done
