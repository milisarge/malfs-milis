for i in /tmp/*.POST; do bash $i; done
rm /tmp/*.POST
rm /tmp/*.PRE
mps -Ggit
