#!/data/data/com.termux/files/usr/bin/bash

OPTS='-aHPESh --info=progress2 --no-compress --delete --delete-excluded --delete-after --rsync-path="sudo rsync"'
SRC="~/storage/shared/"
EXCL='"/Android/","/MIUI/backup/",'
DEST="rsyncuser@192.168.66.40:/mnt/bu1/baksmb/ph1/int/"
RSH="ssh -T -c aes128-gcm@openssh.com -o Compression=no -x -i ~/.ssh/rsync -p 25522"
DATE="$(date +%Y-%m-%d_%H:%M:%S)"
HOST_LOG="$(hostname -s) (this host)"

CMD="rsync ${OPTS} --exclude={${EXCL}} --rsh=\"${RSH}\" ${SRC} $DEST"
echo "Command to do:"
echo $CMD
echo; read -p "Type \"yes\" to start ${HOST_LOG} backup: "
if [ "${REPLY}" != "yes" ]; then
	echo "No \"yes\" typed. Exiting..."; exit 1
fi
DATE="+%F %a %X"
MSG="-- ${HOST_LOG} -- backup"
echo
echo "$(LC_ALL=C date "${DATE}") ${MSG} start ..."
eval time ${CMD}
#echo "${DATE} -- ${RUN} backup done -- ${HOST_LOG}" &&\
[ $? -eq 0 ] && { echo && \
echo "$(LC_ALL=C date "${DATE}") ${MSG} completed successfully" && \
echo "Exiting..." && exit 0; } || { echo && \
echo "$(LC_ALL=C date "${DATE}") ${MSG} completed with warning(s)" && \
echo "You can run the script once more. Exiting..." && exit 1; }

