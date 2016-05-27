. /etc/mpsd.conf

packager="milisarge"
account="$1"
name="$2"
version="$3"
file="$name.html"
url=https://github.com/"$account/$name"

curl -k $url > "$file" 
desc=`sed -n 's|[^<]*<span itemprop="about">\([^<]*\)</span>[^<]*|\1\n|gp' $file`
mkdir -p $name

tee "$name/talimat" > /dev/null <<EOF
# description:$desc
# url:$url
# packager:$packager
# Depends on: 

name=$name
version=$version
release=1
source=(https://github.com/$account/$name/archive/$version.tar.gz)

build () {
	mv $DERLEME_KAYNAKDIZIN/$version.tar.gz $DERLEME_KAYNAKDIZIN/$name-$version.tar.gz
	cd $name-$version
	./autogen.sh
	./configure --prefix=/usr
	make
	make DESTDIR=$PKG install
}

EOF
