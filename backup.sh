#!/bin/bash

BKUPDIR="/mnt/SSD3/backup-arch"

backup ()
{
COMMAND="tar $OPTS --xattrs -czpvf $BKUPDIR/arch-$DEST.tar.gz /$DEST"
echo -e "\n$COMMAND"
echo -n "Backup /$DEST? (y/n): "; read b
case "$b" in
  y ) $COMMAND;;
  n ) echo -e "Bye\n";;
esac
}

echo
echo "1: /efi"
echo "2: /"
echo "3: /var"
echo "4: /home"
echo "0: QUIT"
echo -n "What to backup? "; read a
case "$a" in
  1 ) DEST="efi"
      backup;;
  2 ) DEST="/";
      OPTS='--exclude {"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/media/*","/lost+found/*","/swapfile","/home/*","/mnt/*"}'
      backup;;
  3 ) DEST="var"
      backup;;
  4 ) DEST="home"
      OPTS='--exclude {"/home/*/.cache/*","/home/*/.ccache/*"}'
      backup;;
  * ) echo "Bye";;
esac
