# Description: Low-level cryptographic library that is designed to fit easily in many contexts. 
# URL: http://www.lysator.liu.se/~nisse/nettle/
# Packager: tnut at nutyx dot org

name=nettle
version=3.2
release=1

source=(http://ftp.gnu.org/gnu/$name/$name-$version.tar.gz)

build() {
cd $name-$version
./configure --prefix=/usr
make
make DESTDIR=$PKG install
chmod -v 755 $PKG/usr/lib/libhogweed.so.4.1 $PKG/usr/lib/libnettle.so.6.1
install -v -m755 -d $PKG/usr/share/doc/nettle-$version
rm -rf $PKG/usr/share/info/dir
install -v -m644 nettle.html $PKG/usr/share/doc/nettle-$version
}
