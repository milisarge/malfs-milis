SHELL=/bin/bash

ETCDIR=/etc
LIBDIR=${DESTDIR}/lib/services
EXTDIR=${DESTDIR}${ETCDIR}
MODE=754
DIRMODE=755
CONFMODE=644

all:
	@grep "^install" Makefile | cut -d ":" -f 1
	@echo "Aşağıdaki listeden kurmak istediğiniz servisi seçiniz." 

dizinleri-olustur:
	install -d -m ${DIRMODE} ${EXTDIR}/rc.d/rc{0,1,2,3,4,5,6,S}.d
	install -d -m ${DIRMODE} ${EXTDIR}/rc.d/init.d
	install -d -m ${DIRMODE} ${EXTDIR}/sysconfig

servis-dizini-olustur:
	install -d -m ${DIRMODE} ${LIBDIR}

servis-kur-dhclient: servis-dizini-olustur
	install -m ${MODE} mbd/services/dhclient ${LIBDIR}

servis-kur-dhcpcd: servis-dizini-olustur
	install -m ${MODE} mbd/services/dhcpcd  ${LIBDIR}

servis-kur-bridge: servis-dizini-olustur
	install -m ${MODE} mbd/services/bridge  ${LIBDIR}

servis-kur-ipx: servis-dizini-olustur
	install -m ${MODE} mbd/services/ipx ${LIBDIR}

servis-kur-pppoe: servis-dizini-olustur
	install -m ${MODE} mbd/services/pppoe  ${LIBDIR}
	install -d -m ${DIRMODE} ${EXTDIR}/ppp/peers
	install -m ${CONFMODE} mbd/ppp/pppoe ${EXTDIR}/ppp/peers

servis-kur-wpa: servis-dizini-olustur
	install -m ${MODE} mbd/services/wpa ${LIBDIR}

kur-acpid: dizinleri-olustur
	install -m ${MODE} mbd/init.d/acpid       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc0.d/K32acpid
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc1.d/K32acpid
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc2.d/S18acpid
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc3.d/S18acpid
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc4.d/S18acpid
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc5.d/S18acpid
	ln -sf  ../init.d/acpid ${EXTDIR}/rc.d/rc6.d/K32acpid

kur-alsa: dizinleri-olustur
	install -m ${MODE} mbd/init.d/alsa       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/alsa ${EXTDIR}/rc.d/rc0.d/K35alsa
	ln -sf  ../init.d/alsa ${EXTDIR}/rc.d/rc1.d/K35alsa
	ln -sf  ../init.d/alsa ${EXTDIR}/rc.d/rc6.d/K35alsa
	ln -sf  ../init.d/alsa ${EXTDIR}/rc.d/rcS.d/S60alsa

kur-httpd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/httpd     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc0.d/K28httpd
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc1.d/K28httpd
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc2.d/K28httpd
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc3.d/S32httpd
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc4.d/S32httpd
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc5.d/S32httpd
	ln -sf  ../init.d/httpd ${EXTDIR}/rc.d/rc6.d/K28httpd

kur-hiawatha: dizinleri-olustur
	install -m ${MODE} mbd/init.d/hiawatha     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc0.d/K28hiawatha
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc1.d/K28hiawatha
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc2.d/K28hiawatha
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc3.d/S32hiawatha
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc4.d/S32hiawatha
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc5.d/S32hiawatha
	ln -sf  ../init.d/hiawatha ${EXTDIR}/rc.d/rc6.d/K28hiawatha

kur-lighttpd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/lighttpd     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc0.d/K28lighttpd
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc1.d/K28lighttpd
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc2.d/K28lighttpd
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc3.d/S32lighttpd
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc4.d/S32lighttpd
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc5.d/S32lighttpd
	ln -sf  ../init.d/lighttpd ${EXTDIR}/rc.d/rc6.d/K28lighttpd
	
kur-nginx: dizinleri-olustur
	install -m ${MODE} mbd/init.d/nginx     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc0.d/K28nginx
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc1.d/K28nginx
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc2.d/K28nginx
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc3.d/S32nginx
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc4.d/S32nginx
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc5.d/S32nginx
	ln -sf  ../init.d/nginx ${EXTDIR}/rc.d/rc6.d/K28nginx

kur-php: dizinleri-olustur
	install -m ${MODE} mbd/init.d/php-fpm     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc0.d/K28php-fpm
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc1.d/K28php-fpm
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc2.d/K28php-fpm
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc3.d/S32php-fpm
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc4.d/S32php-fpm
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc5.d/S32php-fpm
	ln -sf  ../init.d/php-fpm ${EXTDIR}/rc.d/rc6.d/K28php-fpm

kur-autofs: dizinleri-olustur
	install -m $(MODE) mbd/init.d/autofs    $(EXTDIR)/rc.d/init.d/
	install -m $(CONFMODE) mbd/sysconfig/autofs.conf $(EXTDIR)/sysconfig/
	ln -sf  ../init.d/autofs $(EXTDIR)/rc.d/rcS.d/S52autofs

kur-atd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/atd       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc0.d/K29atd
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc1.d/K29atd
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc2.d/S68atd
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc3.d/S68atd
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc4.d/S68atd
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc5.d/S68atd
	ln -sf  ../init.d/atd ${EXTDIR}/rc.d/rc6.d/K29atd

kur-avahi: dizinleri-olustur
	install -m ${MODE} mbd/init.d/avahi     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc0.d/K28avahi
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc1.d/K28avahi
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc2.d/S34avahi
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc3.d/S34avahi
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc4.d/S34avahi
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc5.d/S34avahi
	ln -sf  ../init.d/avahi ${EXTDIR}/rc.d/rc6.d/K28avahi

kur-bind: dizinleri-olustur
	install -m ${MODE} mbd/init.d/bind       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc0.d/K49bind
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc1.d/K49bind
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc2.d/K49bind
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc3.d/S22bind
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc4.d/S22bind
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc5.d/S22bind
	ln -sf  ../init.d/bind ${EXTDIR}/rc.d/rc6.d/K49bind

kur-bluetooth: dizinleri-olustur
	install -m ${MODE} mbd/init.d/bluetooth ${EXTDIR}/rc.d/init.d/bluetooth
	install -m ${CONFMODE} mbd/sysconfig/bluetooth ${EXTDIR}/sysconfig/bluetooth 
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc0.d/K27bluetooth
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc1.d/K27bluetooth
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc2.d/S35bluetooth
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc3.d/S35bluetooth
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc4.d/S35bluetooth
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc5.d/S35bluetooth
	ln -sf  ../init.d/bluetooth ${EXTDIR}/rc.d/rc6.d/K27bluetooth

kur-cups: dizinleri-olustur
	install -m ${MODE} mbd/init.d/cups       ${EXTDIR}/rc.d/init.d/
	rm -f ${EXTDIR}/rc.d/rc0.d/K36cups
	rm -f ${EXTDIR}/rc.d/rc2.d/K36cups
	rm -f ${EXTDIR}/rc.d/rc3.d/K36cups
	rm -f ${EXTDIR}/rc.d/rc5.d/K36cups
	rm -f ${EXTDIR}/rc.d/rc2.d/S81cups
	rm -f ${EXTDIR}/rc.d/rc3.d/S81cups
	rm -f ${EXTDIR}/rc.d/rc5.d/S81cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc0.d/K00cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc1.d/K00cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc2.d/S25cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc3.d/S25cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc4.d/S25cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc5.d/S25cups
	ln -sf  ../init.d/cups ${EXTDIR}/rc.d/rc6.d/K00cups

kur-saslauthd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/saslauthd ${EXTDIR}/rc.d/init.d/saslauthd
	install -m ${CONFMODE} mbd/sysconfig/saslauthd ${EXTDIR}/sysconfig/saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc0.d/K49saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc1.d/K49saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc2.d/S24saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc3.d/S24saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc4.d/S24saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc5.d/S24saslauthd
	ln -sf  ../init.d/saslauthd ${EXTDIR}/rc.d/rc6.d/K49saslauthd

kur-dbus: dizinleri-olustur
	install -m ${MODE} mbd/init.d/dbus ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc0.d/K30dbus
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc1.d/K30dbus
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc2.d/S29dbus
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc3.d/S29dbus
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc4.d/S29dbus
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc5.d/S29dbus
	ln -sf  ../init.d/dbus ${EXTDIR}/rc.d/rc6.d/K30dbus

kur-dovecot: dizinleri-olustur
	install -m ${MODE} mbd/init.d/dovecot       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc0.d/K78dovecot
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc1.d/K78dovecot
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc2.d/K78dovecot
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc3.d/S27dovecot
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc4.d/S27dovecot
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc5.d/S27dovecot
	ln -sf  ../init.d/dovecot ${EXTDIR}/rc.d/rc6.d/K78dovecot

kur-wicd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/wicd ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc0.d/K20wicd
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc1.d/K20wicd
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc2.d/S30wicd
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc3.d/S30wicd
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc4.d/S30wicd
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc5.d/S30wicd
	ln -sf  ../init.d/wicd ${EXTDIR}/rc.d/rc6.d/K20wicd

kur-dhcpd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/dhcpd       ${EXTDIR}/rc.d/init.d/dhcpd
	install -m ${CONFMODE} mbd/sysconfig/dhcpd ${EXTDIR}/sysconfig/dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc0.d/K30dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc1.d/K30dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc2.d/K30dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc3.d/S30dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc4.d/S30dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc5.d/S30dhcpd
	ln -sf  ../init.d/dhcpd ${EXTDIR}/rc.d/rc6.d/K30dhcpd

kur-exim: dizinleri-olustur
	install -m ${MODE} mbd/init.d/exim       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc0.d/K25exim
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc1.d/K25exim
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc2.d/K25exim
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc3.d/S35exim
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc4.d/S35exim
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc5.d/S35exim
	ln -sf  ../init.d/exim ${EXTDIR}/rc.d/rc6.d/K25exim

kur-fcron: dizinleri-olustur
	install -m ${MODE} mbd/init.d/fcron      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc0.d/K08fcron
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc1.d/K08fcron
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc2.d/S40fcron
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc3.d/S40fcron
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc4.d/S40fcron
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc5.d/S40fcron
	ln -sf  ../init.d/fcron ${EXTDIR}/rc.d/rc6.d/K08fcron

kur-gdm: dizinleri-olustur
	install -m ${MODE} mbd/init.d/gdm        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc0.d/K05gdm
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc1.d/K05gdm
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc2.d/K05gdm
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc3.d/K05gdm
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc4.d/K05gdm
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc5.d/S95gdm
	ln -sf  ../init.d/gdm ${EXTDIR}/rc.d/rc6.d/K05gdm

kur-gpm: dizinleri-olustur
	install -m ${MODE} mbd/init.d/gpm        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc0.d/K10gpm
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc1.d/K10gpm
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc2.d/S70gpm
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc3.d/S70gpm
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc4.d/S70gpm
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc5.d/S70gpm
	ln -sf  ../init.d/gpm ${EXTDIR}/rc.d/rc6.d/K10gpm

kur-haveged: dizinleri-olustur
	install -m ${MODE} mbd/init.d/haveged        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc0.d/K90haveged
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc1.d/K90haveged
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc2.d/K90haveged
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc3.d/S21haveged
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc4.d/S21haveged
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc5.d/S21haveged
	ln -sf  ../init.d/haveged ${EXTDIR}/rc.d/rc6.d/K90haveged

kur-heimdal: dizinleri-olustur
	install -m ${MODE} mbd/init.d/heimdal        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc0.d/K42heimdal
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc1.d/K42heimdal
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc2.d/K42heimdal
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc3.d/S28heimdal
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc4.d/S28heimdal
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc5.d/S28heimdal
	ln -sf  ../init.d/heimdal ${EXTDIR}/rc.d/rc6.d/K42heimdal

kur-iptables: dizinleri-olustur
	install -m ${MODE} mbd/init.d/iptables        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/iptables ${EXTDIR}/rc.d/rc3.d/S19iptables
	ln -sf  ../init.d/iptables ${EXTDIR}/rc.d/rc4.d/S19iptables
	ln -sf  ../init.d/iptables ${EXTDIR}/rc.d/rc5.d/S19iptables

kur-krb5: dizinleri-olustur
	install -m ${MODE} mbd/init.d/krb5 ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc0.d/K42krb5
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc1.d/K42krb5
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc2.d/K42krb5
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc3.d/S28krb5
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc4.d/S28krb5
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc5.d/S28krb5
	ln -sf ../init.d/krb5 ${EXTDIR}/rc.d/rc6.d/K42krb5

kur-lprng: dizinleri-olustur
	install -m ${MODE} mbd/init.d/lprng      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc0.d/K00lprng
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc1.d/K00lprng
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc2.d/S99lprng
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc3.d/S99lprng
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc4.d/S99lprng
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc5.d/S99lprng
	ln -sf  ../init.d/lprng ${EXTDIR}/rc.d/rc6.d/K00lprng

kur-lxdm: dizinleri-olustur
	install -m ${MODE} mbd/init.d/lxdm        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc0.d/K05lxdm
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc1.d/K05lxdm
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc2.d/K05lxdm
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc3.d/K05lxdm
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc4.d/K05lxdm
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc5.d/S95lxdm
	ln -sf  ../init.d/lxdm ${EXTDIR}/rc.d/rc6.d/K05lxdm
	
kur-lightdm: dizinleri-olustur
	install -m ${MODE} mbd/init.d/lightdm        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc0.d/K05lightdm
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc1.d/K05lightdm
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc2.d/K05lightdm
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc3.d/K05lightdm
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc4.d/K05lightdm
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc5.d/S95lightdm
	ln -sf  ../init.d/lightdm ${EXTDIR}/rc.d/rc6.d/K05lightdm

kur-mdm: dizinleri-olustur
	install -m ${MODE} mbd/init.d/mdm        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc0.d/K05mdm
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc1.d/K05mdm
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc2.d/K05mdm
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc3.d/K05mdm
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc4.d/K05mdm
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc5.d/S95mdm
	ln -sf  ../init.d/mdm ${EXTDIR}/rc.d/rc6.d/K05mdm

kur-mysql: dizinleri-olustur
	install -m ${MODE} mbd/init.d/mysql      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc0.d/K26mysql
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc1.d/K26mysql
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc2.d/K26mysql
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc3.d/S34mysql
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc4.d/S34mysql
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc5.d/S34mysql
	ln -sf  ../init.d/mysql ${EXTDIR}/rc.d/rc6.d/K26mysql

kur-netfs: dizinleri-olustur
	install -m ${MODE} mbd/init.d/netfs      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc0.d/K47netfs
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc1.d/K47netfs
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc2.d/K47netfs
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc3.d/S28netfs
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc4.d/S28netfs
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc5.d/S28netfs
	ln -sf  ../init.d/netfs ${EXTDIR}/rc.d/rc6.d/K47netfs

kur-networkmanager: dizinleri-olustur
	install -m ${MODE} mbd/init.d/networkmanager ${EXTDIR}/rc.d/init.d/networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc0.d/K28networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc1.d/K28networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc2.d/S33networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc3.d/S33networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc4.d/S33networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc5.d/S33networkmanager
	ln -sf  ../init.d/networkmanager ${EXTDIR}/rc.d/rc6.d/K28networkmanager

kur-nfs-client: dizinleri-olustur
	install -m ${MODE} mbd/init.d/nfs-client ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc0.d/K48nfs-client
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc1.d/K48nfs-client
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc2.d/K48nfs-client
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc3.d/S24nfs-client
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc4.d/S24nfs-client
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc5.d/S24nfs-client
	ln -sf  ../init.d/nfs-client ${EXTDIR}/rc.d/rc6.d/K48nfs-client

kur-nfs-server: dizinleri-olustur
	install -m ${MODE} mbd/init.d/nfs-server ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc0.d/K48nfs-server
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc1.d/K48nfs-server
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc2.d/K48nfs-server
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc3.d/S24nfs-server
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc4.d/S24nfs-server
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc5.d/S24nfs-server
	ln -sf  ../init.d/nfs-server ${EXTDIR}/rc.d/rc6.d/K48nfs-server

kur-ntpd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/ntpd       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc0.d/K46ntpd
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc1.d/K46ntpd
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc2.d/K46ntpd
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc3.d/S26ntpd
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc4.d/S26ntpd
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc5.d/S26ntpd
	ln -sf  ../init.d/ntpd ${EXTDIR}/rc.d/rc6.d/K46ntpd

kur-slapd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/slapd ${EXTDIR}/rc.d/init.d/slapd
	install -m ${CONFMODE} mbd/sysconfig/slapd ${EXTDIR}/sysconfig/slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc0.d/K46slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc1.d/K46slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc2.d/S25slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc3.d/S25slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc4.d/S25slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc5.d/S25slapd
	ln -sf  ../init.d/slapd ${EXTDIR}/rc.d/rc6.d/K46slapd

kur-postfix: dizinleri-olustur
	install -m ${MODE} mbd/init.d/postfix    ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc0.d/K25postfix
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc1.d/K25postfix
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc2.d/K25postfix
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc3.d/S35postfix
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc4.d/S35postfix
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc5.d/S35postfix
	ln -sf  ../init.d/postfix ${EXTDIR}/rc.d/rc6.d/K25postfix

kur-postgresql: dizinleri-olustur
	install -m ${MODE} mbd/init.d/postgresql ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc0.d/K26postgresql
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc1.d/K26postgresql
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc2.d/K26postgresql
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc3.d/S34postgresql
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc4.d/S34postgresql
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc5.d/S34postgresql
	ln -sf  ../init.d/postgresql ${EXTDIR}/rc.d/rc6.d/K26postgresql

kur-proftpd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/proftpd    ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc0.d/K28proftpd
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc1.d/K28proftpd
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc2.d/K28proftpd
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc3.d/S32proftpd
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc4.d/S32proftpd
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc5.d/S32proftpd
	ln -sf  ../init.d/proftpd ${EXTDIR}/rc.d/rc6.d/K28proftpd

kur-qpopper: dizinleri-olustur
	install -m ${MODE} mbd/init.d/qpopper   ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc0.d/K23qpopper
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc1.d/K23qpopper
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc2.d/K23qpopper
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc3.d/S37qpopper
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc4.d/S37qpopper
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc5.d/S37qpopper
	ln -sf  ../init.d/qpopper ${EXTDIR}/rc.d/rc6.d/K23qpopper

kur-random: dizinleri-olustur
	install -m ${MODE} mbd/init.d/random     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc0.d/K45random
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc1.d/S25random
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc2.d/S25random
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc3.d/S25random
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc4.d/S25random
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc5.d/S25random
	ln -sf  ../init.d/random ${EXTDIR}/rc.d/rc6.d/K45random

kur-rpcbind: dizinleri-olustur
	install -m ${MODE} mbd/init.d/rpcbind    ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc0.d/K49rpcbind
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc1.d/K49rpcbind
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc2.d/K49rpcbind
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc3.d/S22rpcbind
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc4.d/S22rpcbind
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc5.d/S22rpcbind
	ln -sf  ../init.d/rpcbind ${EXTDIR}/rc.d/rc6.d/K49rpcbind

kur-rsyncd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/rsyncd     ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc0.d/K30rsyncd
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc1.d/K30rsyncd
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc2.d/K30rsyncd
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc3.d/S30rsyncd
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc4.d/S30rsyncd
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc5.d/S30rsyncd
	ln -sf  ../init.d/rsyncd ${EXTDIR}/rc.d/rc6.d/K30rsyncd

kur-samba: dizinleri-olustur
	install -m ${MODE} mbd/init.d/samba      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc0.d/K48samba
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc1.d/K48samba
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc2.d/K48samba
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc3.d/S45samba
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc4.d/S45samba
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc5.d/S45samba
	ln -sf  ../init.d/samba ${EXTDIR}/rc.d/rc6.d/K48samba

kur-pulseaudio: dizinleri-olustur
	install -m ${MODE} mbd/init.d/pulseaudio      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc0.d/K55pulseaudio
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc1.d/K55pulseaudio
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc2.d/K55pulseaudio
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc3.d/S55pulseaudio
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc4.d/S55pulseaudio
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc5.d/S55pulseaudio
	ln -sf  ../init.d/pulseaudio ${EXTDIR}/rc.d/rc6.d/K55pulseaudio

kur-sddm: dizinleri-olustur
	install -m ${MODE} mbd/init.d/sddm        ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc0.d/K05sddm
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc1.d/K05sddm
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc2.d/K05sddm
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc3.d/K05sddm
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc4.d/K05sddm
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc5.d/S95sddm
	ln -sf  ../init.d/sddm ${EXTDIR}/rc.d/rc6.d/K05sddm

kur-plymouth: dizinleri-olustur
	install -m ${MODE} mbd/init.d/plymouth ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc0.d/K20plymouth
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc1.d/K20plymouth
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc2.d/S20plymouth
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc3.d/S20plymouth
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc4.d/S20plymouth
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc5.d/S20plymouth
	ln -sf ../init.d/plymouth ${EXTDIR}/rc.d/rc6.d/K20plymouth

kur-sendmail: dizinleri-olustur
	install -m ${MODE} mbd/init.d/sendmail   ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc0.d/K25sendmail
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc1.d/K25sendmail
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc2.d/K25sendmail
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc3.d/S35sendmail
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc4.d/S35sendmail
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc5.d/S35sendmail
	ln -sf  ../init.d/sendmail ${EXTDIR}/rc.d/rc6.d/K25sendmail

kur-smartd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/smartd    ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc0.d/K70smartd
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc1.d/K70smartd
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc2.d/K70smartd
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc3.d/S21smartd
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc4.d/S21smartd
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc5.d/S21smartd
	ln -sf  ../init.d/smartd ${EXTDIR}/rc.d/rc6.d/K70smartd

kur-slim: dizinleri-olustur
	install -m ${MODE} mbd/init.d/slim  ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc0.d/K05slim
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc1.d/K05slim
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc2.d/K05slim
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc3.d/K05slim
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc4.d/K05slim
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc5.d/S95slim
	ln -sf  ../init.d/slim ${EXTDIR}/rc.d/rc6.d/K05slim

kur-soprano: dizinleri-olustur
	install -m ${MODE} mbd/init.d/soprano    ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc0.d/K35soprano
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc1.d/K35soprano
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc2.d/K35soprano
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc3.d/S48soprano
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc4.d/S48soprano
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc5.d/S48soprano
	ln -sf  ../init.d/soprano ${EXTDIR}/rc.d/rc6.d/K35soprano

kur-swat: dizinleri-olustur
	install -m ${MODE} mbd/init.d/swat      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc0.d/K47swat
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc1.d/K47swat
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc2.d/K47swat
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc3.d/S46swat
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc4.d/S46swat
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc5.d/S46swat
	ln -sf  ../init.d/swat ${EXTDIR}/rc.d/rc6.d/K47swat

kur-sshd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/sshd       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc0.d/K30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc1.d/K30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc2.d/K30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc3.d/S30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc4.d/S30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc5.d/S30sshd
	ln -sf  ../init.d/sshd ${EXTDIR}/rc.d/rc6.d/K30sshd

kur-stunnel: dizinleri-olustur
	install -m ${MODE} mbd/init.d/stunnel    ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc0.d/K47stunnel
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc1.d/K47stunnel
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc2.d/K47stunnel
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc3.d/S55stunnel
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc4.d/S55stunnel
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc5.d/S55stunnel
	ln -sf  ../init.d/stunnel ${EXTDIR}/rc.d/rc6.d/K47stunnel

kur-svn: dizinleri-olustur
	install -m ${MODE} mbd/init.d/svn        ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc0.d/K27svn
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc1.d/K27svn
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc2.d/K27svn
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc3.d/S33svn
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc4.d/S33svn
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc5.d/S33svn
	ln -sf ../init.d/svn ${EXTDIR}/rc.d/rc6.d/K27svn

kur-sysstat: dizinleri-olustur
	install -m ${MODE} mbd/init.d/sysstat    ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/sysstat ${EXTDIR}/rc.d/rcS.d/S85sysstat

kur-unbound: dizinleri-olustur
	install -m ${MODE} mbd/init.d/unbound       ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc0.d/K79unbound
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc1.d/K79unbound
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc2.d/K79unbound
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc3.d/S21unbound
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc4.d/S21unbound
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc5.d/S21unbound
	ln -sf  ../init.d/unbound ${EXTDIR}/rc.d/rc6.d/K79unbound

kur-virtuoso: dizinleri-olustur
	install -m ${MODE} mbd/init.d/virtuoso   ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc0.d/K40virtuoso
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc1.d/K40virtuoso
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc2.d/K40virtuoso
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc3.d/S47virtuoso
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc4.d/S47virtuoso
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc5.d/S47virtuoso
	ln -sf ../init.d/virtuoso ${EXTDIR}/rc.d/rc6.d/K40virtuoso

kur-vsftpd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/vsftpd     ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc0.d/K28vsftpd
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc1.d/K28vsftpd
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc2.d/K28vsftpd
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc3.d/S32vsftpd
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc4.d/S32vsftpd
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc5.d/S32vsftpd
	ln -sf ../init.d/vsftpd ${EXTDIR}/rc.d/rc6.d/K28vsftpd

kur-winbindd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/winbindd      ${EXTDIR}/rc.d/init.d/
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc0.d/K49winbindd
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc1.d/K49winbindd
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc2.d/K49winbindd
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc3.d/S50winbindd
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc4.d/S50winbindd
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc5.d/S50winbindd
	ln -sf  ../init.d/winbindd ${EXTDIR}/rc.d/rc6.d/K49winbindd

kur-xinetd: dizinleri-olustur
	install -m ${MODE} mbd/init.d/xinetd     ${EXTDIR}/rc.d/init.d/
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc0.d/K49xinetd
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc1.d/K49xinetd
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc2.d/K49xinetd
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc3.d/S23xinetd
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc4.d/S23xinetd
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc5.d/S23xinetd
	ln -sf ../init.d/xinetd ${EXTDIR}/rc.d/rc6.d/K49xinetd

sil-atd: 
	rm -f ${EXTDIR}/rc.d/init.d/atd
	rm -f ${EXTDIR}/rc.d/rc0.d/K29atd
	rm -f ${EXTDIR}/rc.d/rc1.d/K29atd
	rm -f ${EXTDIR}/rc.d/rc2.d/S68atd
	rm -f ${EXTDIR}/rc.d/rc3.d/S68atd
	rm -f ${EXTDIR}/rc.d/rc4.d/S68atd
	rm -f ${EXTDIR}/rc.d/rc5.d/S68atd
	rm -f ${EXTDIR}/rc.d/rc6.d/K29atd

sil-acpid:
	rm -f ${EXTDIR}/rc.d/init.d/acpid
	rm -f ${EXTDIR}/rc.d/rc0.d/K32acpid
	rm -f ${EXTDIR}/rc.d/rc1.d/K32acpid
	rm -f ${EXTDIR}/rc.d/rc2.d/S18acpid
	rm -f ${EXTDIR}/rc.d/rc3.d/S18acpid
	rm -f ${EXTDIR}/rc.d/rc4.d/S18acpid
	rm -f ${EXTDIR}/rc.d/rc5.d/S18acpid
	rm -f ${EXTDIR}/rc.d/rc6.d/K32acpid

sil-alsa:
	rm -f ${EXTDIR}/rc.d/init.d/alsa
	rm -f ${EXTDIR}/rc.d/rc0.d/K35alsa
	rm -f ${EXTDIR}/rc.d/rc1.d/K35alsa
	rm -f ${EXTDIR}/rc.d/rc6.d/K35alsa
	rm -f ${EXTDIR}/rc.d/rcS.d/S60alsa

sil-httpd:
	rm -f ${EXTDIR}/rc.d/init.d/httpd
	rm -f ${EXTDIR}/rc.d/rc0.d/K28httpd
	rm -f ${EXTDIR}/rc.d/rc1.d/K28httpd
	rm -f ${EXTDIR}/rc.d/rc2.d/K28httpd
	rm -f ${EXTDIR}/rc.d/rc3.d/S32httpd
	rm -f ${EXTDIR}/rc.d/rc4.d/S32httpd
	rm -f ${EXTDIR}/rc.d/rc5.d/S32httpd
	rm -f ${EXTDIR}/rc.d/rc6.d/K28httpd

sil-hiawatha:
	rm -f ${EXTDIR}/rc.d/init.d/hiawatha
	rm -f ${EXTDIR}/rc.d/rc0.d/K28hiawatha
	rm -f ${EXTDIR}/rc.d/rc1.d/K28hiawatha
	rm -f ${EXTDIR}/rc.d/rc2.d/K28hiawatha
	rm -f ${EXTDIR}/rc.d/rc3.d/S32hiawatha
	rm -f ${EXTDIR}/rc.d/rc4.d/S32hiawatha
	rm -f ${EXTDIR}/rc.d/rc5.d/S32hiawatha
	rm -f ${EXTDIR}/rc.d/rc6.d/K28hiawatha
	
sil-lighttpd:
	rm -f ${EXTDIR}/rc.d/init.d/lighttpd
	rm -f ${EXTDIR}/rc.d/rc0.d/K28lighttpd
	rm -f ${EXTDIR}/rc.d/rc1.d/K28lighttpd
	rm -f ${EXTDIR}/rc.d/rc2.d/K28lighttpd
	rm -f ${EXTDIR}/rc.d/rc3.d/S32lighttpd
	rm -f ${EXTDIR}/rc.d/rc4.d/S32lighttpd
	rm -f ${EXTDIR}/rc.d/rc5.d/S32lighttpd
	rm -f ${EXTDIR}/rc.d/rc6.d/K28lighttpd
	
sil-nginx:
	rm -f ${EXTDIR}/rc.d/init.d/nginx
	rm -f ${EXTDIR}/rc.d/rc0.d/K28nginx
	rm -f ${EXTDIR}/rc.d/rc1.d/K28nginx
	rm -f ${EXTDIR}/rc.d/rc2.d/K28nginx
	rm -f ${EXTDIR}/rc.d/rc3.d/S32nginx
	rm -f ${EXTDIR}/rc.d/rc4.d/S32nginx
	rm -f ${EXTDIR}/rc.d/rc5.d/S32nginx
	rm -f ${EXTDIR}/rc.d/rc6.d/K28nginx

sil-php:
	rm -f ${EXTDIR}/rc.d/init.d/php-fpm
	rm -f ${EXTDIR}/rc.d/rc0.d/K28php-fpm
	rm -f ${EXTDIR}/rc.d/rc1.d/K28php-fpm
	rm -f ${EXTDIR}/rc.d/rc2.d/K28php-fpm
	rm -f ${EXTDIR}/rc.d/rc3.d/S32php-fpm
	rm -f ${EXTDIR}/rc.d/rc4.d/S32php-fpm
	rm -f ${EXTDIR}/rc.d/rc5.d/S32php-fpm
	rm -f ${EXTDIR}/rc.d/rc6.d/K28php-fpm

sil-autofs:
	rm -f $(EXTDIR)/rc.d/init.d/autofs
	rm -f $(EXTDIR)/rc.d/rcS.d/S52autofs

sil-avahi:
	rm -f ${EXTDIR}/rc.d/init.d/avahi
	rm -f ${EXTDIR}/rc.d/rc0.d/K28avahi
	rm -f ${EXTDIR}/rc.d/rc1.d/K28avahi
	rm -f ${EXTDIR}/rc.d/rc2.d/S34avahi
	rm -f ${EXTDIR}/rc.d/rc3.d/S34avahi
	rm -f ${EXTDIR}/rc.d/rc4.d/S34avahi
	rm -f ${EXTDIR}/rc.d/rc5.d/S34avahi
	rm -f ${EXTDIR}/rc.d/rc6.d/K28avahi

sil-bind:
	rm -f ${EXTDIR}/rc.d/init.d/bind
	rm -f ${EXTDIR}/rc.d/rc0.d/K49bind
	rm -f ${EXTDIR}/rc.d/rc1.d/K49bind
	rm -f ${EXTDIR}/rc.d/rc2.d/K49bind
	rm -f ${EXTDIR}/rc.d/rc3.d/S22bind
	rm -f ${EXTDIR}/rc.d/rc4.d/S22bind
	rm -f ${EXTDIR}/rc.d/rc5.d/S22bind
	rm -f ${EXTDIR}/rc.d/rc6.d/K49bind

sil-bluetooth:
	rm -f ${EXTDIR}/rc.d/init.d/bluetooth
	rm -f ${EXTDIR}/rc.d/rc0.d/K27bluetooth
	rm -f ${EXTDIR}/rc.d/rc1.d/K27bluetooth
	rm -f ${EXTDIR}/rc.d/rc2.d/S35bluetooth
	rm -f ${EXTDIR}/rc.d/rc3.d/S35bluetooth
	rm -f ${EXTDIR}/rc.d/rc4.d/S35bluetooth
	rm -f ${EXTDIR}/rc.d/rc5.d/S35bluetooth
	rm -f ${EXTDIR}/rc.d/rc6.d/K27bluetooth

sil-cups:
	rm -f ${EXTDIR}/rc.d/init.d/cups
	rm -f ${EXTDIR}/rc.d/rc0.d/K00cups
	rm -f ${EXTDIR}/rc.d/rc1.d/K00cups
	rm -f ${EXTDIR}/rc.d/rc2.d/S25cups
	rm -f ${EXTDIR}/rc.d/rc3.d/S25cups
	rm -f ${EXTDIR}/rc.d/rc4.d/S25cups
	rm -f ${EXTDIR}/rc.d/rc5.d/S25cups
	rm -f ${EXTDIR}/rc.d/rc6.d/K00cups

sil-saslauthd:
	rm -f ${EXTDIR}/rc.d/init.d/saslauthd
	rm -f ${EXTDIR}/sysconfig/saslauthd
	rm -f ${EXTDIR}/rc.d/rc0.d/K49saslauthd
	rm -f ${EXTDIR}/rc.d/rc1.d/K49saslauthd
	rm -f ${EXTDIR}/rc.d/rc2.d/S24saslauthd
	rm -f ${EXTDIR}/rc.d/rc3.d/S24saslauthd
	rm -f ${EXTDIR}/rc.d/rc4.d/S24saslauthd
	rm -f ${EXTDIR}/rc.d/rc5.d/S24saslauthd
	rm -f ${EXTDIR}/rc.d/rc6.d/K49saslauthd

sil-dbus: 
	rm -f ${EXTDIR}/rc.d/init.d/dbus
	rm -f ${EXTDIR}/rc.d/rc0.d/K30dbus
	rm -f ${EXTDIR}/rc.d/rc1.d/K30dbus
	rm -f ${EXTDIR}/rc.d/rc2.d/S29dbus
	rm -f ${EXTDIR}/rc.d/rc3.d/S29dbus
	rm -f ${EXTDIR}/rc.d/rc4.d/S29dbus
	rm -f ${EXTDIR}/rc.d/rc5.d/S29dbus
	rm -f ${EXTDIR}/rc.d/rc6.d/K30dbus

sil-wicd:
	rm -f ${EXTDIR}/rc.d/init.d/wicd
	rm -f ${EXTDIR}/rc.d/rc0.d/K20wicd
	rm -f ${EXTDIR}/rc.d/rc1.d/K20wicd
	rm -f ${EXTDIR}/rc.d/rc2.d/S30wicd
	rm -f ${EXTDIR}/rc.d/rc3.d/S30wicd
	rm -f ${EXTDIR}/rc.d/rc4.d/S30wicd
	rm -f ${EXTDIR}/rc.d/rc5.d/S30wicd
	rm -f ${EXTDIR}/rc.d/rc6.d/K20wicd

sil-dhcpd:
	rm -f ${EXTDIR}/rc.d/init.d/dhcpd
	rm -f ${EXTDIR}/sysconfig/dhcpd
	rm -f ${EXTDIR}/rc.d/rc0.d/K30dhcpd
	rm -f ${EXTDIR}/rc.d/rc1.d/K30dhcpd
	rm -f ${EXTDIR}/rc.d/rc2.d/K30dhcpd
	rm -f ${EXTDIR}/rc.d/rc3.d/S30dhcpd
	rm -f ${EXTDIR}/rc.d/rc4.d/S30dhcpd
	rm -f ${EXTDIR}/rc.d/rc5.d/S30dhcpd
	rm -f ${EXTDIR}/rc.d/rc6.d/K30dhcpd

sil-dovecot:
	rm -f ${EXTDIR}/rc.d/init.d/dovecot
	rm -f ${EXTDIR}/rc.d/rc0.d/K78dovecot
	rm -f ${EXTDIR}/rc.d/rc1.d/K78dovecot
	rm -f ${EXTDIR}/rc.d/rc2.d/K78dovecot
	rm -f ${EXTDIR}/rc.d/rc3.d/S27dovecot
	rm -f ${EXTDIR}/rc.d/rc4.d/S27dovecot
	rm -f ${EXTDIR}/rc.d/rc5.d/S27dovecot
	rm -f ${EXTDIR}/rc.d/rc6.d/K78dovecot

sil-exim:
	rm -f ${EXTDIR}/rc.d/init.d/exim
	rm -f ${EXTDIR}/rc.d/rc0.d/K25exim
	rm -f ${EXTDIR}/rc.d/rc1.d/K25exim
	rm -f ${EXTDIR}/rc.d/rc2.d/K25exim
	rm -f ${EXTDIR}/rc.d/rc3.d/S35exim
	rm -f ${EXTDIR}/rc.d/rc4.d/S35exim
	rm -f ${EXTDIR}/rc.d/rc5.d/S35exim
	rm -f ${EXTDIR}/rc.d/rc6.d/K25exim

sil-fcron:
	rm -f ${EXTDIR}/rc.d/init.d/fcron
	rm -f ${EXTDIR}/rc.d/rc0.d/K08fcron
	rm -f ${EXTDIR}/rc.d/rc1.d/K08fcron
	rm -f ${EXTDIR}/rc.d/rc2.d/S40fcron
	rm -f ${EXTDIR}/rc.d/rc3.d/S40fcron
	rm -f ${EXTDIR}/rc.d/rc4.d/S40fcron
	rm -f ${EXTDIR}/rc.d/rc5.d/S40fcron
	rm -f ${EXTDIR}/rc.d/rc6.d/K08fcron

sil-gdm:
	rm -f ${EXTDIR}/rc.d/init.d/gdm
	rm -f ${EXTDIR}/rc.d/rc0.d/K05gdm
	rm -f ${EXTDIR}/rc.d/rc1.d/K05gdm
	rm -f ${EXTDIR}/rc.d/rc2.d/K05gdm
	rm -f ${EXTDIR}/rc.d/rc3.d/K05gdm
	rm -f ${EXTDIR}/rc.d/rc4.d/K05gdm
	rm -f ${EXTDIR}/rc.d/rc5.d/S95gdm
	rm -f ${EXTDIR}/rc.d/rc6.d/K05gdm

sil-gpm:
	rm -f ${EXTDIR}/rc.d/init.d/gpm
	rm -f ${EXTDIR}/rc.d/rc0.d/K10gpm
	rm -f ${EXTDIR}/rc.d/rc1.d/K10gpm
	rm -f ${EXTDIR}/rc.d/rc2.d/S70gpm
	rm -f ${EXTDIR}/rc.d/rc3.d/S70gpm
	rm -f ${EXTDIR}/rc.d/rc4.d/S70gpm
	rm -f ${EXTDIR}/rc.d/rc5.d/S70gpm
	rm -f ${EXTDIR}/rc.d/rc6.d/K10gpm

sil-haveged:
	rm -f ${EXTDIR}/rc.d/init.d/haveged
	rm -f ${EXTDIR}/rc.d/rc0.d/K90haveged
	rm -f ${EXTDIR}/rc.d/rc1.d/K90haveged
	rm -f ${EXTDIR}/rc.d/rc2.d/K90haveged
	rm -f ${EXTDIR}/rc.d/rc3.d/S21haveged
	rm -f ${EXTDIR}/rc.d/rc4.d/S21haveged
	rm -f ${EXTDIR}/rc.d/rc5.d/S21haveged
	rm -f ${EXTDIR}/rc.d/rc6.d/K90haveged

sil-heimdal:
	rm -f ${EXTDIR}/rc.d/init.d/heimdal
	rm -f ${EXTDIR}/rc.d/rc0.d/K42heimdal
	rm -f ${EXTDIR}/rc.d/rc1.d/K42heimdal
	rm -f ${EXTDIR}/rc.d/rc2.d/K42heimdal
	rm -f ${EXTDIR}/rc.d/rc3.d/S28heimdal
	rm -f ${EXTDIR}/rc.d/rc4.d/S28heimdal
	rm -f ${EXTDIR}/rc.d/rc5.d/S28heimdal
	rm -f ${EXTDIR}/rc.d/rc6.d/K42heimdal

sil-iptables:
	rm -f ${EXTDIR}/rc.d/init.d/iptables
	rm -f ${EXTDIR}/rc.d/rc3.d/S19iptables
	rm -f ${EXTDIR}/rc.d/rc4.d/S19iptables
	rm -f ${EXTDIR}/rc.d/rc5.d/S19iptables

sil-krb5:
	rm -f ${EXTDIR}/rc.d/init.d/krb5
	rm -f ${EXTDIR}/rc.d/rc0.d/K42krb5
	rm -f ${EXTDIR}/rc.d/rc1.d/K42krb5
	rm -f ${EXTDIR}/rc.d/rc2.d/K42krb5
	rm -f ${EXTDIR}/rc.d/rc3.d/S28krb5
	rm -f ${EXTDIR}/rc.d/rc4.d/S28krb5
	rm -f ${EXTDIR}/rc.d/rc5.d/S28krb5
	rm -f ${EXTDIR}/rc.d/rc6.d/K42krb5
	
sil-plymouth:
	rm -f ${EXTDIR}/rc.d/init.d/plymouth
	rm -f ${EXTDIR}/rc.d/rc0.d/K20plymouth
	rm -f ${EXTDIR}/rc.d/rc1.d/K20plymouth
	rm -f ${EXTDIR}/rc.d/rc2.d/S20plymouth
	rm -f ${EXTDIR}/rc.d/rc3.d/S20plymouth
	rm -f ${EXTDIR}/rc.d/rc4.d/S20plymouth
	rm -f ${EXTDIR}/rc.d/rc5.d/S20plymouth
	rm -f ${EXTDIR}/rc.d/rc6.d/K20plymouth

sil-lprng:
	rm -f ${EXTDIR}/rc.d/init.d/lprng
	rm -f ${EXTDIR}/rc.d/rc0.d/K00lprng
	rm -f ${EXTDIR}/rc.d/rc1.d/K00lprng
	rm -f ${EXTDIR}/rc.d/rc2.d/S99lprng
	rm -f ${EXTDIR}/rc.d/rc3.d/S99lprng
	rm -f ${EXTDIR}/rc.d/rc4.d/S99lprng
	rm -f ${EXTDIR}/rc.d/rc5.d/S99lprng
	rm -f ${EXTDIR}/rc.d/rc6.d/K00lprng

sil-lxdm:
	rm -f ${EXTDIR}/rc.d/init.d/lxdm
	rm -f ${EXTDIR}/rc.d/rc0.d/K05lxdm
	rm -f ${EXTDIR}/rc.d/rc1.d/K05lxdm
	rm -f ${EXTDIR}/rc.d/rc2.d/K05lxdm
	rm -f ${EXTDIR}/rc.d/rc3.d/K05lxdm
	rm -f ${EXTDIR}/rc.d/rc4.d/K05lxdm
	rm -f ${EXTDIR}/rc.d/rc5.d/S95lxdm
	rm -f ${EXTDIR}/rc.d/rc6.d/K05lxdm
	
sil-lightdm:
	rm -f ${EXTDIR}/rc.d/init.d/lightdm
	rm -f ${EXTDIR}/rc.d/rc0.d/K05lightdm
	rm -f ${EXTDIR}/rc.d/rc1.d/K05lightdm
	rm -f ${EXTDIR}/rc.d/rc2.d/K05lightdm
	rm -f ${EXTDIR}/rc.d/rc3.d/K05lightdm
	rm -f ${EXTDIR}/rc.d/rc4.d/K05lightdm
	rm -f ${EXTDIR}/rc.d/rc5.d/S95lightdm
	rm -f ${EXTDIR}/rc.d/rc6.d/K05lightdm
	
sil-mdm:
	rm -f ${EXTDIR}/rc.d/init.d/mdm
	rm -f ${EXTDIR}/rc.d/rc0.d/K05mdm
	rm -f ${EXTDIR}/rc.d/rc1.d/K05mdm
	rm -f ${EXTDIR}/rc.d/rc2.d/K05mdm
	rm -f ${EXTDIR}/rc.d/rc3.d/K05mdm
	rm -f ${EXTDIR}/rc.d/rc4.d/K05mdm
	rm -f ${EXTDIR}/rc.d/rc5.d/S95mdm
	rm -f ${EXTDIR}/rc.d/rc6.d/K05mdm

sil-mysql:
	rm -f ${EXTDIR}/rc.d/init.d/mysql
	rm -f ${EXTDIR}/rc.d/rc0.d/K26mysql
	rm -f ${EXTDIR}/rc.d/rc1.d/K26mysql
	rm -f ${EXTDIR}/rc.d/rc2.d/K26mysql
	rm -f ${EXTDIR}/rc.d/rc3.d/S34mysql
	rm -f ${EXTDIR}/rc.d/rc4.d/S34mysql
	rm -f ${EXTDIR}/rc.d/rc5.d/S34mysql
	rm -f ${EXTDIR}/rc.d/rc6.d/K26mysql

sil-netfs:
	rm -f ${EXTDIR}/rc.d/init.d/netfs
	rm -f ${EXTDIR}/rc.d/rc0.d/K47netfs
	rm -f ${EXTDIR}/rc.d/rc1.d/K47netfs
	rm -f ${EXTDIR}/rc.d/rc2.d/K47netfs
	rm -f ${EXTDIR}/rc.d/rc3.d/S28netfs
	rm -f ${EXTDIR}/rc.d/rc4.d/S28netfs
	rm -f ${EXTDIR}/rc.d/rc5.d/S28netfs
	rm -f ${EXTDIR}/rc.d/rc6.d/K47netfs

sil-networkmanager:
	rm -f ${EXTDIR}/rc.d/init.d/networkmanager
	rm -f ${EXTDIR}/rc.d/rc0.d/K28networkmanager
	rm -f ${EXTDIR}/rc.d/rc1.d/K28networkmanager
	rm -f ${EXTDIR}/rc.d/rc2.d/S33networkmanager
	rm -f ${EXTDIR}/rc.d/rc3.d/S33networkmanager
	rm -f ${EXTDIR}/rc.d/rc4.d/S33networkmanager
	rm -f ${EXTDIR}/rc.d/rc5.d/S33networkmanager
	rm -f ${EXTDIR}/rc.d/rc6.d/K28networkmanager

sil-nfs-client:
	rm -f ${EXTDIR}/rc.d/init.d/nfs-client
	rm -f ${EXTDIR}/rc.d/rc0.d/K48nfs-client
	rm -f ${EXTDIR}/rc.d/rc1.d/K48nfs-client
	rm -f ${EXTDIR}/rc.d/rc2.d/K48nfs-client
	rm -f ${EXTDIR}/rc.d/rc3.d/S24nfs-client
	rm -f ${EXTDIR}/rc.d/rc4.d/S24nfs-client
	rm -f ${EXTDIR}/rc.d/rc5.d/S24nfs-client
	rm -f ${EXTDIR}/rc.d/rc6.d/K48nfs-client

sil-nfs-server:
	rm -f ${EXTDIR}/rc.d/init.d/nfs-server
	rm -f ${EXTDIR}/rc.d/rc0.d/K48nfs-server
	rm -f ${EXTDIR}/rc.d/rc1.d/K48nfs-server
	rm -f ${EXTDIR}/rc.d/rc2.d/K48nfs-server
	rm -f ${EXTDIR}/rc.d/rc3.d/S24nfs-server
	rm -f ${EXTDIR}/rc.d/rc4.d/S24nfs-server
	rm -f ${EXTDIR}/rc.d/rc5.d/S24nfs-server
	rm -f ${EXTDIR}/rc.d/rc6.d/K48nfs-server

sil-ntpd:
	rm -f ${EXTDIR}/rc.d/init.d/ntpd
	rm -f ${EXTDIR}/rc.d/rc0.d/K46ntpd
	rm -f ${EXTDIR}/rc.d/rc1.d/K46ntpd
	rm -f ${EXTDIR}/rc.d/rc2.d/K46ntpd
	rm -f ${EXTDIR}/rc.d/rc3.d/S26ntpd
	rm -f ${EXTDIR}/rc.d/rc4.d/S26ntpd
	rm -f ${EXTDIR}/rc.d/rc5.d/S26ntpd
	rm -f ${EXTDIR}/rc.d/rc6.d/K46ntpd

sil-slapd:
	rm -f ${EXTDIR}/rc.d/init.d/slapd
	rm -f ${EXTDIR}/sysconfig/slapd
	rm -f ${EXTDIR}/rc.d/rc0.d/K46slapd
	rm -f ${EXTDIR}/rc.d/rc1.d/K46slapd
	rm -f ${EXTDIR}/rc.d/rc2.d/S25slapd
	rm -f ${EXTDIR}/rc.d/rc3.d/S25slapd
	rm -f ${EXTDIR}/rc.d/rc4.d/S25slapd
	rm -f ${EXTDIR}/rc.d/rc5.d/S25slapd
	rm -f ${EXTDIR}/rc.d/rc6.d/K46slapd

sil-slim:
	rm -f ${EXTDIR}/rc.d/init.d/slim
	rm -f ${EXTDIR}/rc.d/rc0.d/K05slim
	rm -f ${EXTDIR}/rc.d/rc1.d/K05slim
	rm -f ${EXTDIR}/rc.d/rc2.d/K05slim
	rm -f ${EXTDIR}/rc.d/rc3.d/K05slim
	rm -f ${EXTDIR}/rc.d/rc4.d/K05slim
	rm -f ${EXTDIR}/rc.d/rc5.d/S95slim
	rm -f ${EXTDIR}/rc.d/rc6.d/K05slim

ukur-smartd: c
	rm -f ${EXTDIR}/rc.d/init.d/smartd
	rm -f ${EXTDIR}/rc.d/rc0.d/K70smartd
	rm -f ${EXTDIR}/rc.d/rc1.d/K70smartd
	rm -f ${EXTDIR}/rc.d/rc2.d/K70smartd
	rm -f ${EXTDIR}/rc.d/rc3.d/S21smartd
	rm -f ${EXTDIR}/rc.d/rc4.d/S21smartd
	rm -f ${EXTDIR}/rc.d/rc5.d/S21smartd
	rm -f ${EXTDIR}/rc.d/rc6.d/K70smartd

sil-postfix:
	rm -f ${EXTDIR}/rc.d/init.d/postfix
	rm -f ${EXTDIR}/rc.d/rc0.d/K25postfix
	rm -f ${EXTDIR}/rc.d/rc1.d/K25postfix
	rm -f ${EXTDIR}/rc.d/rc2.d/K25postfix
	rm -f ${EXTDIR}/rc.d/rc3.d/S35postfix
	rm -f ${EXTDIR}/rc.d/rc4.d/S35postfix
	rm -f ${EXTDIR}/rc.d/rc5.d/S35postfix
	rm -f ${EXTDIR}/rc.d/rc6.d/K25postfix

sil-postgresql:
	rm -f ${EXTDIR}/rc.d/init.d/postgresql
	rm -f ${EXTDIR}/rc.d/rc0.d/K26postgresql
	rm -f ${EXTDIR}/rc.d/rc1.d/K26postgresql
	rm -f ${EXTDIR}/rc.d/rc2.d/K26postgresql
	rm -f ${EXTDIR}/rc.d/rc3.d/S34postgresql
	rm -f ${EXTDIR}/rc.d/rc4.d/S34postgresql
	rm -f ${EXTDIR}/rc.d/rc5.d/S34postgresql
	rm -f ${EXTDIR}/rc.d/rc6.d/K26postgresql

sil-proftpd:
	rm -f ${EXTDIR}/rc.d/init.d/proftpd
	rm -f ${EXTDIR}/rc.d/rc0.d/K28proftpd
	rm -f ${EXTDIR}/rc.d/rc1.d/K28proftpd
	rm -f ${EXTDIR}/rc.d/rc2.d/K28proftpd
	rm -f ${EXTDIR}/rc.d/rc3.d/S32proftpd
	rm -f ${EXTDIR}/rc.d/rc4.d/S32proftpd
	rm -f ${EXTDIR}/rc.d/rc5.d/S32proftpd
	rm -f ${EXTDIR}/rc.d/rc6.d/K28proftpd

sil-random:
	rm -f ${EXTDIR}/rc.d/init.d/random
	rm -f ${EXTDIR}/rc.d/rc0.d/K45random
	rm -f ${EXTDIR}/rc.d/rc1.d/S25random
	rm -f ${EXTDIR}/rc.d/rc2.d/S25random
	rm -f ${EXTDIR}/rc.d/rc3.d/S25random
	rm -f ${EXTDIR}/rc.d/rc4.d/S25random
	rm -f ${EXTDIR}/rc.d/rc5.d/S25random
	rm -f ${EXTDIR}/rc.d/rc6.d/K45random

sil-rpcbind: 
	rm -f ${EXTDIR}/rc.d/init.d/rpcbind
	rm -f ${EXTDIR}/rc.d/rc0.d/K49rpcbind
	rm -f ${EXTDIR}/rc.d/rc1.d/K49rpcbind
	rm -f ${EXTDIR}/rc.d/rc2.d/K49rpcbind
	rm -f ${EXTDIR}/rc.d/rc3.d/S22rpcbind
	rm -f ${EXTDIR}/rc.d/rc4.d/S22rpcbind
	rm -f ${EXTDIR}/rc.d/rc5.d/S22rpcbind
	rm -f ${EXTDIR}/rc.d/rc6.d/K49rpcbind

sil-rsyncd:
	rm -f ${EXTDIR}/rc.d/init.d/rsyncd
	rm -f ${EXTDIR}/rc.d/rc0.d/K30rsyncd
	rm -f ${EXTDIR}/rc.d/rc1.d/K30rsyncd
	rm -f ${EXTDIR}/rc.d/rc2.d/K30rsyncd
	rm -f ${EXTDIR}/rc.d/rc3.d/S30rsyncd
	rm -f ${EXTDIR}/rc.d/rc4.d/S30rsyncd
	rm -f ${EXTDIR}/rc.d/rc5.d/S30rsyncd
	rm -f ${EXTDIR}/rc.d/rc6.d/K30rsyncd

sil-samba:
	rm -f ${EXTDIR}/rc.d/init.d/samba
	rm -f ${EXTDIR}/rc.d/rc0.d/K48samba
	rm -f ${EXTDIR}/rc.d/rc1.d/K48samba
	rm -f ${EXTDIR}/rc.d/rc2.d/K48samba
	rm -f ${EXTDIR}/rc.d/rc3.d/S45samba
	rm -f ${EXTDIR}/rc.d/rc4.d/S45samba
	rm -f ${EXTDIR}/rc.d/rc5.d/S45samba
	rm -f ${EXTDIR}/rc.d/rc6.d/K48samba
	
sil-pulseaudio:
	rm -f ${EXTDIR}/rc.d/init.d/pulseaudio
	rm -f ${EXTDIR}/rc.d/rc0.d/K55pulseaudio
	rm -f ${EXTDIR}/rc.d/rc1.d/K55pulseaudio
	rm -f ${EXTDIR}/rc.d/rc2.d/K55pulseaudio
	rm -f ${EXTDIR}/rc.d/rc3.d/S55pulseaudio
	rm -f ${EXTDIR}/rc.d/rc4.d/S55pulseaudio
	rm -f ${EXTDIR}/rc.d/rc5.d/S55pulseaudio
	rm -f ${EXTDIR}/rc.d/rc6.d/K55pulseaudio

sil-sddm:
	rm -f ${EXTDIR}/rc.d/init.d/sddm
	rm -f ${EXTDIR}/rc.d/rc0.d/K05sddm
	rm -f ${EXTDIR}/rc.d/rc1.d/K05sddm
	rm -f ${EXTDIR}/rc.d/rc2.d/K05sddm
	rm -f ${EXTDIR}/rc.d/rc3.d/K05sddm
	rm -f ${EXTDIR}/rc.d/rc4.d/K05sddm
	rm -f ${EXTDIR}/rc.d/rc5.d/S95sddm
	rm -f ${EXTDIR}/rc.d/rc6.d/K05sddm

sil-sendmail:
	rm -f ${EXTDIR}/rc.d/init.d/sendmail
	rm -f ${EXTDIR}/rc.d/rc0.d/K25sendmail
	rm -f ${EXTDIR}/rc.d/rc1.d/K25sendmail
	rm -f ${EXTDIR}/rc.d/rc2.d/K25sendmail
	rm -f ${EXTDIR}/rc.d/rc3.d/S35sendmail
	rm -f ${EXTDIR}/rc.d/rc4.d/S35sendmail
	rm -f ${EXTDIR}/rc.d/rc5.d/S35sendmail
	rm -f ${EXTDIR}/rc.d/rc6.d/K25sendmail

sil-sshd:
	rm -f ${EXTDIR}/rc.d/init.d/sshd
	rm -f ${EXTDIR}/rc.d/rc0.d/K30sshd
	rm -f ${EXTDIR}/rc.d/rc1.d/K30sshd
	rm -f ${EXTDIR}/rc.d/rc2.d/K30sshd
	rm -f ${EXTDIR}/rc.d/rc3.d/S30sshd
	rm -f ${EXTDIR}/rc.d/rc4.d/S30sshd
	rm -f ${EXTDIR}/rc.d/rc5.d/S30sshd
	rm -f ${EXTDIR}/rc.d/rc6.d/K30sshd

sil-stunnel:
	rm -f ${EXTDIR}/rc.d/init.d/stunnel
	rm -f ${EXTDIR}/rc.d/rc0.d/K47stunnel
	rm -f ${EXTDIR}/rc.d/rc1.d/K47stunnel
	rm -f ${EXTDIR}/rc.d/rc2.d/K47stunnel
	rm -f ${EXTDIR}/rc.d/rc3.d/S55stunnel
	rm -f ${EXTDIR}/rc.d/rc4.d/S55stunnel
	rm -f ${EXTDIR}/rc.d/rc5.d/S55stunnel
	rm -f ${EXTDIR}/rc.d/rc6.d/K47stunnel

sil-svn:
	rm -f ${EXTDIR}/rc.d/init.d/svn
	rm -f ${EXTDIR}/rc.d/rc0.d/K27svn
	rm -f ${EXTDIR}/rc.d/rc1.d/K27svn
	rm -f ${EXTDIR}/rc.d/rc2.d/K27svn
	rm -f ${EXTDIR}/rc.d/rc3.d/S33svn
	rm -f ${EXTDIR}/rc.d/rc4.d/S33svn
	rm -f ${EXTDIR}/rc.d/rc5.d/S33svn
	rm -f ${EXTDIR}/rc.d/rc6.d/K27svn

sil-sysstat:
	rm -f ${EXTDIR}/rc.d/init.d/sysstat
	rm -f ${EXTDIR}/rc.d/rcS.d/S85sysstat

sil-unbound:
	rm -f ${EXTDIR}/rc.d/init.d/unbound
	rm -f ${EXTDIR}/rc.d/rc0.d/K79unbound
	rm -f ${EXTDIR}/rc.d/rc1.d/K79unbound
	rm -f ${EXTDIR}/rc.d/rc2.d/K79unbound
	rm -f ${EXTDIR}/rc.d/rc3.d/S21unbound
	rm -f ${EXTDIR}/rc.d/rc4.d/S21unbound
	rm -f ${EXTDIR}/rc.d/rc5.d/S21unbound
	rm -f ${EXTDIR}/rc.d/rc6.d/K79unbound

sil-virtuoso:
	rm -f ${EXTDIR}/rc.d/init.d/virtuoso
	rm -f ${EXTDIR}/rc.d/rc0.d/K40virtuoso
	rm -f ${EXTDIR}/rc.d/rc1.d/K40virtuoso
	rm -f ${EXTDIR}/rc.d/rc2.d/K40virtuoso
	rm -f ${EXTDIR}/rc.d/rc3.d/S47virtuoso
	rm -f ${EXTDIR}/rc.d/rc4.d/S47virtuoso
	rm -f ${EXTDIR}/rc.d/rc5.d/S47virtuoso
	rm -f ${EXTDIR}/rc.d/rc6.d/K40virtuoso

sil-vsftpd:
	rm -f ${EXTDIR}/rc.d/init.d/vsftpd
	rm -f ${EXTDIR}/rc.d/rc0.d/K28vsftpd
	rm -f ${EXTDIR}/rc.d/rc1.d/K28vsftpd
	rm -f ${EXTDIR}/rc.d/rc2.d/K28vsftpd
	rm -f ${EXTDIR}/rc.d/rc3.d/S32vsftpd
	rm -f ${EXTDIR}/rc.d/rc4.d/S32vsftpd
	rm -f ${EXTDIR}/rc.d/rc5.d/S32vsftpd
	rm -f ${EXTDIR}/rc.d/rc6.d/K28vsftpd

sil-winbindd:
	rm -f ${EXTDIR}/rc.d/init.d/winbindd
	rm -f ${EXTDIR}/rc.d/rc0.d/K49winbindd
	rm -f ${EXTDIR}/rc.d/rc1.d/K49winbindd
	rm -f ${EXTDIR}/rc.d/rc2.d/K49winbindd
	rm -f ${EXTDIR}/rc.d/rc3.d/S50winbindd
	rm -f ${EXTDIR}/rc.d/rc4.d/S50winbindd
	rm -f ${EXTDIR}/rc.d/rc5.d/S50winbindd
	rm -f ${EXTDIR}/rc.d/rc6.d/K49winbindd

sil-xinetd:
	rm -f ${EXTDIR}/rc.d/init.d/xinetd
	rm -f ${EXTDIR}/rc.d/rc0.d/K49xinetd
	rm -f ${EXTDIR}/rc.d/rc1.d/K49xinetd
	rm -f ${EXTDIR}/rc.d/rc2.d/K49xinetd
	rm -f ${EXTDIR}/rc.d/rc3.d/S23xinetd
	rm -f ${EXTDIR}/rc.d/rc4.d/S23xinetd
	rm -f ${EXTDIR}/rc.d/rc5.d/S23xinetd
	rm -f ${EXTDIR}/rc.d/rc6.d/K49xinetd

.PHONY: all dizinleri-olustur servis-dizini-olustur \
	servis-kur-dhclient \
	servis-kur-dhcpcd \
	servis-kur-ipx \
	servis-kur-pppoe \
	kur-atd \
	kur-acpid \
	kur-alsa \
	kur-avahi \
	kur-httpd \
	kur-php \
	kur-bind \
	kur-bluetooth \
	kur-cups \
	kur-saslauthd \
	kur-wicd \
	kur-dhcpd \
	kur-dovecot \
	kur-exim \
	kur-fcron \
	kur-gdm \
	kur-gpm \
	kur-heimdal \
	kur-iptables \
	kur-krb5 \
	kur-lprng \
	kur-mysql \
	kur-netfs \
	kur-networkmanager \
	kur-nfs-client \
	kur-nfs-server \
	kur-ntpd \
	kur-slapd \
	kur-postfix \
	kur-postgresql \
	kur-proftpd \
	kur-random \
	kur-rsync \
	kur-samba \
	kur-sddm \
	kur-sendmail \
	kur-soprano \
	kur-sshd \
	kur-stunnel \
	kur-svn \
	kur-sysstat \
	kur-vsftpd \
	kur-unbound \
	kur-virtuoso \
	kur-winbindd \
	kur-xinetd \
	sil-atd \
	sil-acpid \
	sil-alsa \
	sil-avahi \
	sil-httpd \
	sil-php \
	sil-bind \
	sil-bluetooth \
	sil-cups \
	sil-saslauthd \
	sil-wicd \
	sil-dhcpd \
	sil-dovecot \
	sil-exim \
	sil-fcron \
	sil-gdm \
	sil-gpm \
	sil-heimdal \
	sil-iptables \
	sil-krb5 \
	sil-lprng \
	sil-mysql \
	sil-netfs \
	sil-networkmanager \
	sil-nfs-client \
	sil-nfs-server \
	sil-ntpd \
	sil-slapd \
	sil-postfix \
	sil-postgresql \
	sil-proftpd \
	sil-random \
	sil-rsync \
	sil-samba \
	sil-sddm \
	sil-sendmail \
	sil-soprano \
	sil-sshd \
	sil-stunnel \
	sil-svn \
	sil-sysstat \
	sil-unbound \
	sil-virtuoso \
	sil-vsftpd   \
	sil-winbindd \
	sil-xinetd
