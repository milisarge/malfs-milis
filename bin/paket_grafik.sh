#!/bin/sh
[ "`which dot`" = "" ] && exit 1
[ $1 ] && paket=$1 || exit 1
[ -f $paket.grafik ] && rm $paket.grafik
[ -f $paket.png ] && rm $paket.png
echo "digraph {" > $paket.grafik
mps -dly $paket
for gerek in `cat tumgerekler.liste`;do
	echo "<${gerek}> -> <${paket}>;" >> $paket.grafik
done
echo "}" >> $paket.grafik
cat $paket.grafik | dot -T png > $paket.png
