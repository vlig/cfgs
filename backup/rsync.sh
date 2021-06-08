#!/usr/bin/env bash

DEST=/ftp/backups
OPTS='-aHAXPESh --info=progress2 --no-compress --numeric-ids --delete --delete-excluded --delete-after'
EXCL='"/dev/","/proc/","/sys/","/tmp/","/run/","/media/","/lost+found/","/*/lost+found/","/swapfile","/var/swap","/mnt/","/var/empty/","/var/run/","/var/tmp/","/.snapshots/","/home/*/.gvfs/","/var/lib/dhcpcd/"'
EXC2='"/home/*/.thumbnails/","/home/*/.cache/mozilla/","/home/*/.cache/chromium/","/home/*/.local/share/Trash/"'
EXCB='"/usr/src/","/usr/ports/","/usr/doc/","/usr/obj/"'
SRC=/
PORT=22
CIPH='aes128-gcm@openssh.com'
NOCONFIRM=false; RUN=REAL

if (($(id -u) != 0)); then
	echo "Must be root. Exiting..."; exit 2
fi

#echo; echo "Root login must be permitted."; echo
#echo Syntax:
#echo 'rsync.sh [-h|--host HOST] [-p|--port PORT] [--exclude-2] [--exclude-b] [-n|--dry-run] [-y|--no-confirm]'; echo
#echo "--exclude-2 -- excludes from backup the following:"
#echo "${EXC2}."
#echo "--exclude-b -- excludes from backup the following (useful only for BSD hosts):"
#echo "${EXCB}."

TEMP=`getopt -o h:p:ny --long host:,port:,exclude-2,exclude-b,dry-run,no-confirm -n 'rsync.sh' -- "$@"`
eval set -- "$TEMP"
while true; do
	case "$1" in
		-h|--host)		HOST="$2"; shift ;;
		-p|--port)		PORT="$2"; shift ;;
		--exclude-2)		EXCL+=",${EXC2}" ;;
		--exclude-b)		EXCL+=",${EXCB}" ;;
		-n|--dry-run)		OPTS+=" --dry-run"; RUN=TEST ;;
		-y|--no-confirm)	NOCONFIRM=true ;;
		?*)	break ;;
	esac
	shift
done
if [ -z "${HOST}" ]; then
	HOST="$(hostname -s)"
	HOST_LOG+=" (this host)"
	unset PORT
else
	HOST_LOG="${HOST}"
	SRC="root@${HOST}:/"
	OPTS+=" -e \"ssh -T -c $CIPH -o Compression=no -x -i /root/.ssh/rsync -p $PORT\""
fi
DIR="${DEST}/${HOST}"
if [ ${RUN} = REAL ]; then
	if [ ! -d ${DIR} ]; then
		read -ern 1 -p "No ${DIR} directory. Create? [Y/n] "
		REPLY=${REPLY:-y}
		if [[ "${REPLY}" = [Yy] ]]; then
			mkdir ${DIR} && chmod 775 ${DIR} &&\
			echo "Done. Ready for backup."
			[ $? -ne 0 ] && { echo "Directory creation error." && exit 2; }
		else
			echo "No ${DIR} - no backup. Exiting..." && exit 1
		fi
	fi
fi	

CMD="rsync ${OPTS} --exclude={${EXCL}} ${SRC}"
echo; echo "Command to do:"
printf "${CMD} ${DIR}/\n"; echo
if [ ${NOCONFIRM} = false ]; then
	read -p "Type \"yes\" to start ${HOST_LOG} backup in ${RUN} mode: "
	if [ "${REPLY}" != "yes" ]; then
		echo "No \"yes\" typed. Exiting..."; exit 1
	fi
fi
echo
DATE='+%Y-%m-%d_%H-%M-%S'
#DATE="$(date +%Y-%m-%d_%H-%M-%S)"
TGT="${DIR}/last"
#TGT="${DIR}/${DATE}"
if [ ${RUN} = REAL ]; then
	if [ ! -d ${TGT} ]; then
		mkdir ${TGT} && chmod 775 ${TGT} ||\
		echo  "Target directory error" && exit 2
	fi
fi
echo "$(date ${DATE}) -- ${RUN} backup start -- ${HOST_LOG}"
eval "time ${CMD} ${TGT}"; echo
[ $? -eq 0 ] && \
{ echo "$(date ${DATE}) -- ${RUN} backup done -- ${HOST_LOG}" && echo && exit 0; } || \
{ echo "$(date ${DATE}) -- ${RUN} backup done with errors! -- ${HOST_LOG}" && echo && exit 1; }

#https://wiki.archlinux.org/index.php/rsync
#https://www.pointsoftware.ch/2012/09/12/howto-local-and-remote-snapshot-backup-using-rsync-with-hard-links/
#https://stackoverflow.com/a/7948533

