# Tanım: Low-level cryptographic library that is designed to fit easily in many contexts. 
# URL: http://www.lysator.liu.se/~nisse/nettle/
# Paketçi: tnut at nutyx dot org

isim=nettle
surum=3.2
devir=1

kaynak=(http://ftp.gnu.org/gnu/$isim/$isim-$surum.tar.gz)

derle() {
cd $isim-$surum
./configure --prefix=/usr
make
make DESTDIR=$PKG install
chmod -v 755 $PKG/usr/lib/libhogweed.so.4.1 $PKG/usr/lib/libnettle.so.6.1
install -v -m755 -d $PKG/usr/share/doc/nettle-$surum
rm -rf $PKG/usr/share/info/dir
install -v -m644 nettle.html $PKG/usr/share/doc/nettle-$surum
}
