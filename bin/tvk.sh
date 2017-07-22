#!/bin/bash
[ -f `type -p asciinema` ] && pip3 install asciinema
echo "Terminal Video Kayit"
asciinema rec -t "$1"
