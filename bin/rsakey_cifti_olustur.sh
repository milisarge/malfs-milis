#!/bin/bash
#rsakey_cifti_olustur
#des3 parametresi olursa sifre sorar
openssl genrsa -des3 -out private.pem 2048
openssl rsa -in private.pem -outform PEM -pubout -out public.pem
