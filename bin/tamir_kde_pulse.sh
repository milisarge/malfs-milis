#!/bin/bash
mkdir -p /root/.config/autostart-scripts
if [ ! -f /root/.config/autostart-scripts/pulse.sh ];then
	cp /root/ayarlar/kde/.config/autostart-scripts/pulse.sh /root/.config/autostart-scripts/pulse.sh
	echo "gerekli pulse.sh dosyasi olusturuldu."
else
	echo "gerekli pulse.sh dosyasi mevcut."
fi
