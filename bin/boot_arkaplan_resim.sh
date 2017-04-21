#!/bin/bash
convert -resize 640x480 -depth 16 -colors 65536 $1 arkaplan.png
