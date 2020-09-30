#!/bin/bash

BKUPDIR="/mnt/SSD3/backup-arch"

backup ()
{
COMMAND="tar $OPTS --xattrs -czpvf $BKUPDIR/arch-$FILE.tar.gz $DEST"
echo -e "\n$COMMAND"
echo -n "Backup $DEST? (y/n): "; read b
case "$b" in
  y ) $COMMAND;;
  * ) echo -e "Bye\n";;
esac
}

echo
echo "e: /efi"
echo "r: / (root)"
echo "v: /var"
echo "h: /home"
echo "p: pacman database"
echo "0: QUIT"
echo -n "What to backup? "; read a
case "$a" in
  e ) FILE=efi; DEST=/$FILE
      backup;;
  r ) FILE=root; DEST=/
      OPTS='--exclude {"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/media/*","/lost+found/*","/swapfile","/home/*","/mnt/*"}'
      backup;;
  v ) FILE=var; DEST=/$FILE
      backup;;
  h ) FILE=home; DEST=/$FILE
      OPTS='--exclude {"/home/*/.cache/*","/home/*/.ccache/*"}'
      backup;;
  p ) pacman -Qqe > $BKUPDIR/pkglist.txt
      tar -сjf $BKUPDIR/pacman_database.tar.bz2 /var/lib/pacman/local;;
  * ) echo "Bye";;
esac
