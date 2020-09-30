#!/bin/bash

BKUPDIR="/mnt/SSD3/backup-arch"

backup ()
{
COMMAND="tar $OPTS --xattrs -czpvf $BKUPDIR/arch-$FILE.tar.gz $DEST"
echo -e "\n$COMMAND"
echo -n "Backup $DEST? (y/n): "; read b
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
  1 ) FILE=efi; DEST=/$FILE
      backup;;
  2 ) FILE=root; DEST=/
      OPTS='--exclude {"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/media/*","/lost+found/*","/swapfile","/home/*","/mnt/*"}'
      backup;;
  3 ) FILE=var; DEST=/$FILE
      backup;;
  4 ) FILE=home; DEST=/$FILE
      OPTS='--exclude {"/home/*/.cache/*","/home/*/.ccache/*"}'
      backup;;
  * ) echo "Bye";;
esac
