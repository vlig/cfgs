#!/bin/sh

mplayer -really-quiet -vc null -vo null ~/Music/logonsound/* </dev/null &
mount ~/mnt/yadisk 
sleep 20 && kstart --skiptaskbar kontact --iconify
#sleep 10 && kstart --skiptaskbar nixnote2
sc-deskstop.py start
