#!/usr/bin/env bash
# shashlik-gui 1.0
#
# Copyright (c) 2017 Elias Ojala
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# https://github.com/theel0ja/shashlik-gui

FILE=`zenity --file-selection --title="Yüklemek istediğiniz bir .apk dosyası seçin"`
case $? in
         0)
                case "${FILE##*.}" in
                                   apk)
                                        zenity --question --text="$FILE dosyasını yüklemek istiyor musunuz?"
                                        case $? in
                                                 0)
                                                    /opt/shashlik/bin/shashlik-install $FILE
                                                 ;;     
                                                 1)
                                                    zenity --warning --text="Uygulama yüklenemedi.";;
                                                -1)
                                                    zenity --error --text="Beklenmeyen bir hata oluştu.";;
                                        esac
                                        ;;
                                   *)
                                        zenity --error --text="Geçersiz dosya türü.";;
                esac
            ;;
         1)
                zenity --error --text="Dosya seçilmedi.";;
        -1)
                zenity --error --text="Beklenmeyen bir hata oluştu.";;
esac
