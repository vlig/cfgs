#!/usr/bin/env bash

DEST="/mnt/BU1/bak/pc2-arch"
TIME="`date +%Y%m%d_%H%M%S`"

backup ()
{
COMMAND="tar -czpv --xattrs $EXC -f $DEST/$FILE-$TIME.tar.gz $SRC"
#COMMAND="mkdir $DEST/$FILE-$TIME && rsync -aHAXSxh --numeric-ids \
#         --delete --delete-excluded --delete-after --progress $EXC $SRC $DEST/$FILE-$TIME/"
echo "$COMMAND"
echo -n "Backup $FILE ($SRC)? (y/n): "; read b
case "$b" in
  y ) $COMMAND; exit 0;;
  * ) echo -e "Cancelled"; exit 0;;
esac
}

if [[ -d $DEST ]]
then
  echo "e: /efi"
  echo "r: / (root)"
  echo "v: /var"
  echo "h: /home"
  echo "p: pacman database"
  echo "q: Quit"
  echo -n "What to backup? "; read a
  case "$a" in
    e ) FILE=efi; SRC=/$FILE
        backup; exit 0;;
    r ) FILE=root; SRC=/
        EXC="--exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/var/* --exclude=/tmp/* --exclude=/run/* --exclude=/media/* --exclude=/lost+found --exclude=/swapfile --exclude=/home/* --exclude=/mnt/*"
        backup; exit 0;;
    v ) FILE=var; SRC=/$FILE
        backup; exit 0;;
    h ) FILE=home; SRC=/$FILE
        EXC="--exclude=/home/*/.cache/* --exclude=/home/*/.ccache/*"
        backup; exit 0;;
    p ) pacman -Qqe > $DEST/pkglist-$TIME.txt
        tar -сjf $DEST/pacman_database-$TIME.tar.bz2 /var/lib/pacman/local;
        exit 0;;
    * ) echo "Exit"; exit 0;;
  esac
else
  echo "$DEST doesn't exist! Fix the DEST variable first."; exit 1
fi
