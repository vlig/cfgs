#!/bin/bash

#https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#List_of_installed_packages
#https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Back_up_the_pacman_database
#https://wiki.archlinux.org/index.php/Full_system_backup_with_tar

BKUPDIR="./"

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
