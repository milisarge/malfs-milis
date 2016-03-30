#tek tek calıstır

cp /usr/bin/vlc /usr/bin/vlc-backup 

needle=$(objdump -d /usr/bin/vlc | grep euid | tail -1 | awk '{print "\\x"$2"\\x"$3"\\x"$4"\\x"$5"\\x"$6;}') 

sed -ir "s/$needle/\xb8\x01\x00\x00\x00/" /usr/bin/vlc
