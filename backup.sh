#!/bin/bash

DEST="/mnt/BU1/bak/pc2-arch/"
TIME="`date +%Y%m%d_%H%M%S`"

backup ()
{
COMMAND="tar $EXC --xattrs -czpvf $DEST/$FILE-$TIME.tar.gz $SRC"
#COMMAND="mkdir $DEST/$FILE-$TIME && rsync -aHAXNSxhv --numeric-ids \
#         --delete --delete-excluded --delete-after --progress $EXC $SRC $DEST/$FILE-$TIME/"
echo -e "\n$COMMAND"
echo -n "Backup $FILE ($SRC)? (y/n): "; read b
case "$b" in
  y ) $COMMAND; exit 0;;
  * ) echo -e "Cancelled\n"; exit 0;;
esac
}

if [[ -d $DEST ]]
then
  echo
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
        EXC='--exclude {"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/media/*","/lost+found/*","/swapfile","/home/*","/mnt/*"}'
        backup; exit 0;;
    v ) FILE=var; SRC=/$FILE
        backup; exit 0;;
    h ) FILE=home; SRC=/$FILE
        EXC='--exclude {"/home/*/.cache/*","/home/*/.ccache/*"}'
        backup; exit 0;;
    p ) pacman -Qqe > $DEST/pkglist-$TIME.txt
        tar -сjf $DEST/pacman_database-$TIME.tar.bz2 /var/lib/pacman/local;
        exit 0;;
    * ) echo "Exit"; exit 0;;
  esac
else
  echo "$DEST doesn't exist! Fix the DEST variable first."; exit 1
fi
