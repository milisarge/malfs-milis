#!/bin/sh

. /usr/bin/gettext.sh


# Internal
lgettext() { gettext -d 'x' "$@"; }
translate_query() {
	case $1 in
		y) lgettext "y";;
		Y) lgettext "Y";;
		n) lgettext "n";;
		N) lgettext "N";;
		# Support other cases but keep them untranslated.
		*) echo "$1" ;;
	esac
}
okmsg="$(lgettext 'Done')"
ermsg="$(lgettext 'Failed')"
: ${okcolor=32}
: ${ercolor=31}
: ${decolor=36}

# Parse cmdline options and store values in a variable.
for opt in "$@"; do
	opt_name="${opt%%=*}"; opt_name="$(echo -n "${opt_name#--}" | tr -c 'a-zA-Z0-9' '_')"
	case "$opt" in
		--[0-9]*=*)	export _$opt_name="${opt#*=}" ;;
		--[0-9]*)	export _$opt_name=yes ;;
		--*=*)		export  $opt_name="${opt#*=}" ;;
		--*)		export  $opt_name=yes ;;
	esac
done
[ "$HTTP_REFERER" ] && output='html'




# i18n functions
_()  { local T="$1"; shift; printf "$(eval_gettext "$T")" "$@"; echo; }
_n() { local T="$1"; shift; printf "$(eval_gettext "$T")" "$@"; }
_p() { local S="$1" P="$2" N="$3"; shift 3; printf "$(ngettext "$S" "$P" "$N")" "$@"; }

# Get terminal columns
get_cols() { stty size 2>/dev/null | awk -vc=$cols 'END{print c?c:($2 && $2<80)?$2:80}'; }

# Last command status
status() {
	local ret_code=$?
	[ -n "$quiet" -a "$ret_code" -eq 0 ] && return
	[ -n "$quiet" ] && action "$saved_action" no-quiet

	case $ret_code in
		0) local msg="$okmsg" color="$okcolor";;
		*) local msg="$ermsg" color="$ercolor";;
	esac
	case $output in
		raw|gtk) echo " $msg";;
		html) echo " <span class=\"float-right color$color\">$msg</span>";;
		*) echo -e "[ \\033[1;${color}m$msg\\033[0;39m ]";;
	esac
}

# Line separator
separator() {
	[ -n "$quiet" ] && return
	case $output in
		gtk) echo '--------';;
		html) echo -n '<hr/>';;
		*) printf "%$(get_cols)s\n" | tr ' ' "${1:-=}";;
	esac
}

# New line
newline() {
	[ -z "$quiet" ] && echo
}

# Display a bold message
boldify() {
	[ -n "$quiet" ] && return
	case $output in
		raw)  echo "$@" ;;
		gtk)  echo "<b>$@</b>" ;;
		html) echo "<strong>$@</strong>" ;;
		*) echo -e "\\033[1m$@\\033[0m" ;;
	esac
}

# renkli mesaj
ryaz() {
	[ -n "$quiet" ] && return
	: ${color=$1}
	shift
	case $output in
		raw|gtk) echo "$@";;
		html)    echo -n "<span class=\"color$color\">$@</span>";;
		*)  case $color in
				0*) echo -e "\\033[${color:-38}m$@\\033[39m";;
				*)  echo -e "\\033[1;${color:-38}m$@\\033[0;39m";;
			esac;;
	esac
	unset color
}

# Indent text
indent() {
	[ -n "$quiet" ] && return
	local in="$1"
	shift
	echo -e "\033["$in"G $@";
}

# Extended MeSsaGe output
emsg() {
	[ -n "$quiet" ] && return
	local sep="\n$(separator)\n"
	case $output in
		raw)
			echo "$@" | sed -e 's|<b>||g; s|</b>||g; s|<c [0-9]*>||g; \
			s|</c>||g; s|<->|'$sep'|g; s|<n>|\n|g; s|<i [0-9]*>| |g' ;;
		gtk)
			echo "$@" | sed -e 's|<c [0-9]*>||g; s|</c>||g; s|<->|'$sep'|g; \
			s|<n>|\n|g; s|<i [0-9]*>| |g' ;;
		html)
			echo "$@" | sed -e 's|<b>|<strong>|g; s|</b>|</strong>|g; \
			s|<c \([0-9]*\)>|<span class="color\1">|g; s|</c>|</span>|g; \
			s|<n>|<br/>|g; s|<->|<hr/>|g; s|<i [0-9]*>| |g' ;;
		*)
			echo -en "$(echo "$@" | sed -e 's|<b>|\\033[1m|g; s|</b>|\\033[0m|g;
			s|<c 0\([0-9]*\)>|\\033[\1m|g; s|<c \([1-9][0-9]*\)>|\\033[1;\1m|g;
			s|</c>|\\033[0;39m|g; s|<n>|\n|g;
			s|<->|'$sep'|g; s|<i \([0-9]*\)>|\\033[\1G|g')"
			[ "$1" != "-n" ] && echo
			;;
	esac
}

# Check if user is logged as root
check_root() {
	if [ $(id -u) -ne 0 ]; then
		lgettext "You must be root to execute:"; echo " $(basename $0) $@"
		exit 1
	fi
}

# Display debug info when --debug is used.
debug() {
	[ -n "$debug" ] && echo "$(colorize $decolor 'DEBUG:') $1"
}

# Confirmation
confirm() {
	if [ -n "$yes" ]; then
		true
	else
		if [ -n "$1" ]; then
			echo -n "$1 "
		else
			echo -n " ($(translate_query y)/$(translate_query N)) ? "
		fi
		read answer
		[ "$answer" == "$(translate_query y)" ]
	fi
}

# Log islemleri
log() {
	echo "$(date '+%F %R') : $@" >> ${faaliyet:-/var/log/islem.log}
}

# Print two-column list of options with descriptions
optlist() {
	[ -n "$quiet" ] && return
	local in="$(echo "$1" | sed 's|		*|	|g')" w=$(get_cols) col1=1 line
	IFS=$'\n'
	for line in $in; do
		col=$(echo -n "$line" | cut -f1 | wc -m)
		[ $col -gt $col1 ] && col1=$col
	done
	echo "$in" | sed 's|\t|&\n|' | fold -sw$((w - col1 - 4)) | \
	sed "/\t/!{s|^.*$|[$((col1 + 4))G&|g}" | sed "/\t$/{N;s|.*|  &|;s|\t\n||}"
}

# Wrap words in long terminal message
longline() {
	[ -n "$quiet" ] && return
	local w=$(get_cols)
	echo -e "$@" | fold -sw$w
}

# Print localized title
title() {
	[ -n "$quiet" ] && return
	case $output in
		html) echo "<section><header>$(_ "$@")</header><pre class=\"scroll\">";;
		*) newline; boldify "$(_ "$@")"; separator;;
	esac
}

# Print footer
footer() {
	[ -n "$quiet" ] && return
	case $output in
		html) echo "</pre><footer>$1</footer></section>";;
		*)    separator; echo "$1"; [ -n "$1" ] && newline;;
	esac
}

# Print current action
saved_action=''
action() {
	saved_action="$1"
	[ -n "$quiet" -a -z "$2" ] && return
	local w c scol msg chars
	w=$(_ 'w'); w=${w/w/10}
	c=$(get_cols)
	scol=$(( $c - $w ))
	msg="$(_n "$@" | fold -sw$scol)"
	chars=$(echo -n "$msg" | tail -n1 | wc -m)
	msg="$(printf '%s%'$(( $scol - $chars ))'s' "$msg" '')"

	case $output in
		raw|gtk|html) echo -n "$msg";;
		*) echo -ne "\033[0;33m$msg\033[0m";;
	esac
}

# Print long line as list item
itemize() {
	[ -n "$quiet" ] && return
	case $output in
		gtk) echo "$@";;
		*)
			local inp="$@" w=$(get_cols) first offset
			first="$(echo -e "$inp" | fold -sw$w | head -n1)"
			echo "$first"
			cols1="$(echo "${first:1}" | wc -c)"
			offset=$(echo "$first" | sed -n 's|^\([^:\*-]*[:\*-]\).*$|\1|p' | wc -m)
			echo "${inp:$cols1}" | fold -sw$((w - offset)) | awk \
				'($0){printf "%'$offset's%s\n","",$0}'
			;;
	esac
}
