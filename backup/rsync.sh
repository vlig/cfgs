#!/usr/bin/env bash

OPTS='-aHAXPESh --info=progress2 --no-compress --numeric-ids --delete --delete-excluded --delete-after'
EXCL='"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/media/*","lost+found/","/swapfile","/var/swap","/mnt/*","/var/empty/*","/var/run/*","/var/tmp/*","/.snapshots/",".gvfs/","/var/lib/dhcpcd/"'
EXC2='".thumbnails/",".cache/mozilla/",".cache/chromium/",".cache/google-chrome/",".local/share/Trash/",".ccache/",".cache/yay/**/src/"'
EXCB='"/usr/src/*","/usr/ports/*","/usr/doc/*","/usr/obj/*"'
PORT=22

if (($(id -u) != 0)); then
	echo "Must be executed as the superuser only. Exiting..."; exit 2
fi

#echo "PERMIT SSH ROOT LOGIN TO SOURCE HOST FIRSTLY"
#echo "usage: ./rsync.sh [--host HOST [--port PORT]] --dest DEST [OPTION] ..."
#echo options:
#echo "--exclude-2		exclude cashes, trash, etc. (check out the script)"
#echo "--exclude-b		excludes for BSD hosts (check out the script)"
#echo "--dry-run, -n		perform a trial run with no changes made"
#echo "--no-confirm, -y		run non-interactively"
#echo "--help, -h (*)           show this help (* -h is help only on its own)"

TEMP=`getopt -o ny --long host:,port:,dest:,exclude-2,exclude-b,dry-run,no-confirm -n 'rsync.sh' -- "$@"`
eval set -- "$TEMP"
while true; do
	case "$1" in
		--host)			HOST="$2"; shift ;;
		--port)			PORT="$2"; shift ;;
		--dest)			DEST="$2"; shift ;;
		--exclude-2)		EXCL+=",${EXC2}" ;;
		--exclude-b)		EXCL+=",${EXCB}" ;;
		-n|--dry-run)		OPTS+=" --dry-run"; RUN=" (in TEST mode)" ;;
		-y|--no-confirm)	CONFIRM=false;;
		?*)	break ;;
	esac
	shift
done
[ -z "${DEST}" ] && echo "No destination specified. Exiting..." && exit 1

if [ -z "${HOST}" ]; then
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
DIR="${DEST}${HOST}/"
if [ -z ${RUN} ]; then
	if [ ! -d ${DIR} ]; then
		read -ern 1 -p "${HOST} backup directory doesn\'t exist (${DIR}). Create? [Y/n] "
		REPLY=${REPLY:-y}
		if [[ "${REPLY}" = [Yy] ]]; then
			mkdir ${DIR} && chmod 775 ${DIR} &&\
			echo "Done. Ready for backup."
			[ $? -ne 0 ] && { echo "${HOST} backup directory creation error." && exit 2; }
		else
			echo "${HOST} backup directory creation rejected. Exiting..." && exit 1
		fi
	fi
fi	

CMD="rsync ${OPTS} --exclude={${EXCL}} ${SRC}"
echo "Command to do:"
printf "${CMD} ${DIR}\n"
if [[ -z ${CONFIRM} ]]; then
	echo; read -p "Type \"yes\" to start full ${HOST_LOG} backup${RUN}: "
	if [ "${REPLY}" != "yes" ]; then
		echo "No \"yes\" typed. Exiting..."; exit 1
	fi
fi
TGT="${DIR}last"
#TGT="${DIR}$(LC_ALL=C date +%y%m%d-%a)"
if [[ -z ${RUN} ]]; then
	if [ ! -d ${TGT} ]; then
		mkdir ${TGT} && chmod 775 ${TGT} || \
		echo  "Target directory error" && exit 2
	fi
fi

DATE="+%F %a %X"
MSG="-- ${HOST_LOG} -- backup"
echo
echo "$(LC_ALL=C date "${DATE}") ${MSG} start${RUN} ..."
eval time ${CMD} ${TGT}
[ $? -eq 0 ] && { echo && \
echo "$(LC_ALL=C date "${DATE}") ${MSG} completed successfully${RUN}" && \
echo "Exiting..." && exit 0; } || { echo && \
echo "$(LC_ALL=C date "${DATE}") ${MSG} completed with warning(s)${RUN}!" && \
echo "You can run the script once more. Exiting..." && exit 1; }

