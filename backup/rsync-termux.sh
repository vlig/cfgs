#!/data/data/com.termux/files/usr/bin/bash

OPTS='-rltHPESh --info=progress2 --no-compress --delete --delete-excluded --delete-after'
# --rsync-path="sudo rsync"'
SRC="~/storage/shared/"
EXCL='"/Android/","/MIUI/backup/","/DCIM/","/Books/books.fbreader.org",".thumbnails"'
PORT=22
ENV=STORAGE_BACKUP_DEST

OPTS_T='-aHPESh --info=progress2 --no-compress --numeric-ids --delete --delete-excluded --delete-after'
SRC_T="/data/data/com.termux/files/*"
EXCL_T='"usr/tmp/"'
DEST_T="../termux-files/"

#echo "${ENV} ENVIRONMENT VARIABLE MUST BE SET FIRSTLY"
#echo "usage: ./rsync-termux.sh [-t] [-p PORT] [OPTION] ..."
#echo options:
#echo "-t	Termux backup, otherwise ~/storage/shared backup"
#echo "-y	run non-interactively"
#echo "-n	perform a trial run with no changes made"
#echo "-h (*)	show this help (* -h is help only on its own)"

DEST=$(eval "echo \${$ENV}")
if [[ -z ${DEST} ]]; then
	echo "${ENV} environment variable must be set. Exiting..." && exit 1
fi
while getopts tp:ny flag
do
	case "${flag}" in
		t) T=\ Termux; OPTS=${OPTS_T}; SRC=${SRC_T}; EXCL=${EXCL_T}; DEST+=${DEST_T};;
		p) PORT=${OPTARG};;
		n) OPTS+=" --dry-run"; RUN=" in TEST mode";;
		y) CONFIRM=false;;
	esac
done

RSH="ssh -T -c aes128-gcm@openssh.com -o Compression=no -x -i ~/.ssh/rsync -p ${PORT}"
CMD="rsync ${OPTS} --exclude={${EXCL}} --rsh=\"${RSH}\" ${SRC} ${DEST}"
echo "Command to do:"
echo ${CMD}
if [[ -z ${CONFIRM} ]]; then
	echo; read -p "Type \"yes\" to start${T} backup${RUN}: "
	if [ "${REPLY}" != "yes" ]; then
		echo "No \"yes\" typed. Exiting..."; exit 1
	fi
fi
DATE="+%F %a %X"
echo
echo "$(LC_ALL=C date "${DATE}") --${T} backup start${RUN} ..."
cd ~/.. && eval time ${CMD} && cd ~
[ $? -eq 0 ] && { echo && \
echo "$(LC_ALL=C date "${DATE}") --${T} backup completed successfully${RUN}" && \
echo "Exiting..." && exit 0; } || { echo && \
echo "$(LC_ALL=C date "${DATE}") --${T} backup completed with warning(s)${RUN}!" && \
echo "You can run the script once more. Exiting..." && exit 1; }

