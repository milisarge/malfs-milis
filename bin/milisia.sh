#!/bin/bash
load_pid()
{
    PID=$(pgrep -d " " -f "cjdroute")
}

load_pid

durdur()
{
    if [ -z "$PID" ]; then
        echo "milisia-cj çalışmıyor!"
        return 1
    else
        kill $PID &> /dev/null
        while [ -n "$(pgrep -d " " -f "cjdroute")" ]; do
            echo "* milisia-cj kapanması bekleniyor..."
            sleep 1;
        done
        if [ $? -gt 0 ]; then return 1; fi
    fi
}

baslat()
{
    if [ -z "$PID" ]; then
        if [ ! -f /dev/net/tun ]; then
			mps kurkos cjdns
        fi
        cjdroute < /etc/cjdroute.conf
    else
        echo "milisia-cj zaten calısmakta"
        return 1
    fi
}

durum()
{
    echo -n "* milisia-cj is "
    if [ -z "$PID" ]; then
        echo "çalışmıyor"
        exit 1
    else
        echo "çalışıyor"
        exit 0
    fi
}

case "$1" in
    "baslat" )
        baslat
        ;;
    "yebaslat" )
        durdur
        load_pid
        baslat
        ;;
    "durdur" )
        durdur
        ;;
    "durum" )
        durum
        ;;
    "kontrol" )
        ps aux | grep -v 'grep' | grep 'cjdns core' > /dev/null 2>/dev/null || start
        ;;
    *)
        echo "kullanım: $0 {baslat|durdur|yebaslat|durum|kontrol}"
esac
