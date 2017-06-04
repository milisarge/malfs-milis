#!/bin/bash
# yerel depo yenilenmesinde kullanılır. 
# yerel deponuz içinde konsol açıp yereldepo_yenile komutu veriniz.
mkdir -p ../yeniler
for pkt in `cat /depo/paketler/paket.vt |  awk '{print $3}'`; do
	if [ -f $pkt ];then
		mv $pkt  ../yeniler/
	else
		echo "$pkt indirin"
	fi
done
