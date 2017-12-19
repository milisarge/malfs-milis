#!/bin/bash
[ $1 ] && stat --format '%a' $1 || exit 1;
