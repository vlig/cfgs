#!/usr/bin/env bash

####################
# EXCLUDE PATTERNS #
####################
#
# Basic:
EXCL='"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/media/*","/mnt/*","/export/*","\$RECYCLE.BIN/*","lost+found/","/swapfile","/var/swap","/var/empty/*","/var/run/*","/var/tmp/*","/.snapshots/",".gvfs/","/var/lib/dhcpcd/"'
## mounts for backup, network dirs, etc.:
## (already included via -x flag)
## ,"/vol/*","/net/*","/srv/nfs/*"'
#
# Extra (caches, thumbnails, etc):
EXC2='".thumbnails/",".cache/mozilla/",".cache/chromium/",".cache/google-chrome/",".local/share/Trash/",".ccache/",".cache/yay/**/src/"'
#
# BSD-hosts specific:
EXCB='"/usr/src/*","/usr/ports/*","/usr/doc/*","/usr/obj/*","/compat/linux/dev/*","/compat/linux/proc/*","/compat/linux/sys/*","/compat/linux/var/empty/*","/compat/linux/var/run/*","/usr/home/*/*.core","/usr/home/*/*.raw*"'
####################

# Pre-set options, do not change
OPTS='-aHAXxPESh --info=progress2 --no-compress --numeric-ids --delete --delete-excluded --delete-after'
PORT=22
EXCF=

USAGE="Usage: ./rsync.sh [ --host HOST [ --port PORT ] ] --dest DEST [ OPTIONS ]"

Help()
{
  # display help
  echo "PERMIT SSH ROOT LOGIN TO SOURCE HOST FIRSTLY."
  echo "Note: GNU getopt is required."
  echo
  echo $USAGE
  echo
  echo "OPTIONS (check the script for variables):"
  echo "--exclude-2	exclude extra patterns (EXC2 variable)"
  echo "--exclude-bsd	exclude BSD-hosts specific patterns (EXCB variable)"
  echo "--exclude-from	read exclude patterns from file"
  echo "--dry-run,-n	perform a trial run with no changes made"
  echo "--no-confirm,-y	run non-interactively"
  echo "--help, -h (*)	show this help (* -h is help only on its own"
}

# Input section and usage info
TEMP=`getopt -o nyh --long host:,port:,dest:,exclude-2,exclude-bsd,exclude-from:,dry-run,no-confirm,help -n 'rsync.sh' -- "$@"`
eval set -- "$TEMP"
while true; do
	case "$1" in
		--host)			HOST="$2"; shift ;;
		--port)			PORT="$2"; shift ;;
		--dest)			DEST="$2"; shift ;;
		--exclude-2)		EXCL+=",${EXC2}" ;;
		--exclude-bsd)		EXCL+=",${EXCB}" ;;
		--exclude-from) 	EXCF="\"$( pwd; )/${2}\""; shift ;;
		-n|--dry-run)		OPTS+=" --dry-run"; RUN=" (in TEST mode)" ;;
		-y|--no-confirm)	CONFIRM=false;;
		-h|--help)		Help && break ;;
		?*)	echo "$USAGE" &&\
			echo "Wrong parameters. Use \"--help\" for more help." &&\
			break; shift ;;
	esac
	shift
done

# Check if non-root
if (($(id -u) != 0)); then
	echo "Must be executed as the superuser only. Exiting..."; exit 2
fi

# Ping the remote host
if ! { [ -z $HOST ] || [ $HOST == localhost ]; }; then
	echo "Requesting for host $HOST... "
	ping -c1 $HOST  # &>/dev/null
	if [ $? -eq 0 ]
		then echo OK; sleep 1
		else echo "not responding. Exiting..."; exit 1
	fi
fi

# Set more variables
[ -z "${DEST}" ] && echo "No destination specified. Exiting..." && exit 1
if { [ -z $HOST ] || [ $HOST == localhost ]; }; then
	SRC=/
	HOST="$(hostname -s)"
	HOST_LOG="${HOST} (this host)"
	unset PORT
else
	SRC="root@${HOST}:/"
	HOST_LOG="${HOST}"
	CIPH='aes128-gcm@openssh.com'
OPTS+=" -e \"ssh -T -c $CIPH -o Compression=no -x -i /root/.ssh/rsync -p $PORT\""
fi

# Check if the remote directory exists
DEST=$(echo ${DEST} |sed -E 's/\/+$//g')\/	# check "/" on $DEST end
DIR="${DEST}${HOST}/"
if [ -z ${RUN} ]; then
	if [ ! -d ${DIR} ]; then read -ern 1 -p \
		"${HOST} backup directory doesn\'t exist (${DIR}). Create? [Y/n] "
		REPLY=${REPLY:-y}
		if [[ "${REPLY}" = [Yy] ]]; then
			mkdir ${DIR} && chmod 775 ${DIR} &&\
			echo "Done. Ready for backup."
			[ $? -ne 0 ] && \
			{ echo "${HOST} backup directory creation error." && \
			exit 2; }
		else
			echo "${HOST} backup directory creation rejected. \
			Exiting..." && exit 1
		fi
	fi
fi	

# Form and show the full command right before running, finishing touches...
CMD="rsync ${OPTS} --exclude={${EXCL}} --exclude-from=${EXCF} ${SRC}"
echo "Command to do:"
printf "${CMD} ${DIR}\n"
if [[ -z ${CONFIRM} ]]; then
	echo; read -p "Type \"yes\" to start full ${HOST_LOG} backup${RUN}: "
	if [ "${REPLY}" != "yes" ]; then
		echo "No \"yes\" typed. Exiting..."; exit 1
	fi
fi
TGT="${DIR}last"
# TODO: target dirs rotating
# by Days, Weeks, Months, Quarters, Years, Leap years, using hardlinks
# or by day(D), 7D(W), 4*7D(M), 3*4*7D(Q), 4*3*4*7D(Y), 4*4*3*4*7D(L)
# or by day(D), 6D(W), 5*6D(M), 3*5*6D(Q), 4*3*5*6D(Y), 4*4*3*5*6D(L)
# Q 90(91) 91 92 92
# or ... ?
#TGT="${DIR}$(LC_ALL=C date +%y%m%d-%a)"
if [[ -z ${RUN} ]]; then
	if [ ! -d ${TGT} ]; then
		mkdir ${TGT} && chmod 775 ${TGT} || \
		echo  "Target directory error" && exit 2
	fi
fi

# ... including logs setup
DATE="+%F %a %X"
MSG="-- ${HOST_LOG} -- backup"
# TODO: logs
# TODO: logs rotating

# Run at last!
echo
echo "$(LC_ALL=C date "${DATE}") ${MSG} start${RUN} ..."
eval time ${CMD} ${TGT}
[ $? -eq 0 ] && { echo && \
echo "$(LC_ALL=C date "${DATE}") ${MSG} completed successfully${RUN}" && \
echo "Exiting..." && exit 0; } || { echo && \
echo "$(LC_ALL=C date "${DATE}") ${MSG} completed with warning(s)${RUN}!" && \
echo "Consider rerun. Exiting..." && exit 1; }

