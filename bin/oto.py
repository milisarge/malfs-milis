#!/usr/bin/python
import os
import sys
file=open(sys.argv[1])
i = 2 
kod = ""
data = "\n"
print len(sys.argv)
while i != len(sys.argv):
    kod = kod + " " + sys.argv[i]
    i=i+1
while "\n"  in data :
    data=file.readline()
    os.system(kod + " " + data )
    print kod + " " + data
    i = i+1
