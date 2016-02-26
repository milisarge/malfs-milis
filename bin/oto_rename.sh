#test sonuclarını gor uygunsa -n i kaldır komutu ver.
shopt -s globstar
rename  -n 's/Pkgfile/talimat/' **
rename  -n 's/post-install/kur-kos/' **
rename  -n 's/pre-install/kos-kur/' **
rename  -n 's/.README/.okubeni/' **
rename  -n 's/-kos-kur/.kos-kur/' **
rename  -n 's/-kur-kos/.kur-kos/' **
