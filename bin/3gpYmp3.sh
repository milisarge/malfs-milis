#!/bin/sh
# bir dizindeki 3gp formatlı videoları mp3 e çevirir.
find . -iname "*.3gp" -print0 | xargs -0 -I 3gpfile ffmpeg -i 3gpfile -c:a libmp3lame $(basename 3gpfile).mp3
