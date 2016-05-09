#ustversion=1.6.2
ustversion=$1
cd /tmp
if [ ! -f go${ustversion}.src.tar.gz ];then
	wget https://storage.googleapis.com/golang/go${ustversion}.src.tar.gz
fi
tar xf /sources/go${ustversion}.src.tar.gz -C .
ln -s /opt/go /$HOME/go1.4
cd go/src/
CGO_ENABLED=0; GOROOT_BOOTSTRAP=/opt/go
./make.bash
go version
rm /$HOME/go1.4
cd -
