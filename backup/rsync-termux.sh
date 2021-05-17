#!/data/data/com.termux/files/usr/bin/bash

OPTS='-aHPESh --info=progress2 --no-compress --delete --delete-excluded --rsync-path="sudo rsync"'
SRC="~/storage/shared/"
EXCL='"/Android/","/MIUI/backup/",'
DEST="rsyncuser@192.168.66.40:/mnt/bu1/baksmb/ph1/int/"
RSH="ssh -T -c aes128-gcm@openssh.com -o Compression=no -x -i ~/.ssh/rsync -p 25522"
DATE="$(date +%Y-%m-%d_%H:%M:%S)"
HOST_LOG="$(hostname -s) (this host)"

CMD="rsync ${OPTS} --exclude={${EXCL}} --rsh=\"${RSH}\" ${SRC} $DEST"
echo; echo $CMD; echo
read -p "Type \"yes\" to start ${HOST_LOG} backup, else exit: "
if [ "${REPLY}" != "yes" ]; then
	echo "No \"yes\" typed. Exiting..."; exit 0
fi
echo
echo "${DATE} -- ${RUN} backup start -- ${HOST_LOG}"
eval ${CMD} && echo &&\
echo "${DATE} -- ${RUN} backup done -- ${HOST_LOG}" &&\
exit 0
