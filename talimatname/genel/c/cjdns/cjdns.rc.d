#!/usr/bin/env bash

# This script is licensed under the GPL2 and includes modified content from the GPL2 licensed /etc/rc.d/functions script that used to be included in Archlinux

### Modified selection from the now deprecated /etc/rc.d/functions ###
calc_columns () {
    STAT_COL=80
    if [[ ! -t 1 ]]; then
        USECOLOR=""
    elif [[ -t 0 ]]; then
        # stty will fail when stdin isn't a terminal
        STAT_COL=$(stty size)
        # stty gives "rows cols"; strip the rows number, we just want columns
        STAT_COL=${STAT_COL##* }
    elif tput cols &>/dev/null; then
        # is /usr/share/terminfo already mounted, and TERM recognized?
        STAT_COL=$(tput cols)
    fi
    if (( STAT_COL == 0 )); then
        # if output was 0 (serial console), set default width to 80
        STAT_COL=80
        USECOLOR=""
    fi

    # we use 13 characters for our own stuff
    STAT_COL=$(( STAT_COL - 13 ))

    if [[ -t 1 ]]; then
        SAVE_POSITION="\e[s"
        RESTORE_POSITION="\e[u"
        DEL_TEXT="\e[$(( STAT_COL + 4 ))G"
    else
        SAVE_POSITION=""
        RESTORE_POSITION=""
        DEL_TEXT=""
    fi
}

calc_columns

# disable colors on broken terminals
TERM_COLORS=$(tput colors 2>/dev/null)
if (( $? != 3 )); then
    case $TERM_COLORS in
        *[!0-9]*) USECOLOR="";;
        [0-7])    USECOLOR="";;
        '')       USECOLOR="";;
    esac
fi
unset TERM_COLORS

deltext() {
    printf "${DEL_TEXT}"
}

stat_busy() {
    printf "${C_OTHER}${PREFIX_REG} ${C_MAIN}${1}${C_CLEAR} "
    printf "${SAVE_POSITION}"
    deltext
    printf "   ${C_OTHER}[${C_BUSY}BUSY${C_OTHER}]${C_CLEAR} "
}

stat_done() {
    deltext
    printf "   ${C_OTHER}[${C_DONE}DONE${C_OTHER}]${C_CLEAR} \n"
}

stat_fail() {
    deltext
    printf "   ${C_OTHER}[${C_FAIL}FAIL${C_OTHER}]${C_CLEAR} \n"
}

status_started() {
    deltext
    echo -ne "$C_OTHER[${C_STRT}STARTED$C_OTHER]$C_CLEAR "
}

status_stopped() {
    deltext
    echo -ne "$C_OTHER[${C_STRT}STOPPED$C_OTHER]$C_CLEAR "
}

# Return PID of $1
get_pid() {
    pidof -o %PPID $1 || return 1
}

# set colors
if [[ $USECOLOR != [nN][oO] ]]; then
    if tput setaf 0 &>/dev/null; then
        C_CLEAR=$(tput sgr0)                 # clear text
        C_MAIN=${C_CLEAR}$(tput bold)        # main text
        C_OTHER=${C_MAIN}$(tput setaf 4)     # prefix & brackets
        C_SEPARATOR=${C_MAIN}$(tput setaf 0) # separator
        C_BUSY=${C_CLEAR}$(tput setaf 6)     # busy
        C_FAIL=${C_MAIN}$(tput setaf 1)      # failed
        C_DONE=${C_MAIN}                     # completed
        C_BKGD=${C_MAIN}$(tput setaf 5)      # backgrounded
        C_H1=${C_MAIN}                       # highlight text 1
        C_H2=${C_MAIN}$(tput setaf 6)        # highlight text 2
    else
        C_CLEAR="\e[m"          # clear text
        C_MAIN="\e[;1m"         # main text
        C_OTHER="\e[1;34m"      # prefix & brackets
        C_SEPARATOR="\e[1;30m"  # separator
        C_BUSY="\e[;36m"        # busy
        C_FAIL="\e[1;31m"       # failed
        C_DONE=${C_MAIN}        # completed
        C_BKGD="\e[1;35m"       # backgrounded
        C_H1=${C_MAIN}          # highlight text 1
        C_H2="\e[1;36m"         # highlight text 2
    fi
fi

PREFIX_REG="::"

### CJDNS service ###
. /etc/default/cjdns

PID=$(get_pid $CJDROUTE)

case "$1" in
    start)
        stat_busy "Starting cjdns"

        #START CJDNS AND ENABLE THE DAEMON IF IT SUCCEEDS
        if [ -z "$PID" ]; then
            cjdns.sh start &> /dev/null
            if [ $? -gt 0 ]; then
                stat_busy "Unable to start the daemon"
                stat_fail
                exit 1
            else
                stat_done
            fi
        else
            stat_busy "The daemon is already running"
            stat_fail
            exit 1
        fi
    ;;
    stop)
        stat_busy "Stopping cjdns"
        cjdns.sh stop
        if [ $? -gt 0 ]; then
            stat_busy "The daemon was not running"
            stat_fail
        else
            stat_done
        fi
    ;;
    restart)
        $0 stop
        while [ ! -z "$PID" -a -d "/proc/$PID" ]; do sleep 1; done
            $0 start
        ;;
    status)
        stat_busy "The daemon is currently..."
        if [ $(cjdns.sh status | grep -c not) = 0 ]; then status_started; else status_stopped; fi
        ;;
    *)
        echo "usage: $0 {start|stop|restart|status}"
esac

exit 0
