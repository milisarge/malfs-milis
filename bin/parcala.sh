#!/bin/bash
sonek=`openssl rand -base64 10`
mkdir -p $1.parcalar
split  --additional-suffix="$sonek" --byte=256k $1 $1.parcalar/$1.
#birlestirmek icin
#cat hedef.dosya.parcalar* > hedef.dosya 
