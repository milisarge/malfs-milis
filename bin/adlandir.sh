#!/bin/bash

for file in $(find ./* -name 'Pkgfile')
do
  mv $file $(echo "$file" | sed -r 's|Pkgfile|talimat|g')
done
for file in $(find ./* -name '*.post-install')
do
  mv $file $(echo "$file" | sed -r 's|.post-install|.kur-kos|g')
done
echo "isimler değiştirildi"
