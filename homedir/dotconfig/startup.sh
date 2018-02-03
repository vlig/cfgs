#!/bin/sh

#xinput --set-prop 9 'libinput Accel Profile Enabled' 1, 0
#mplayer -really-quiet -vc null -vo null ~/Music/logonsound/* </dev/null &
plaympeg ~/Music/logonsound/* </dev/null &
mount ~/mnt/yadisk 
#sleep 20 && kstart --skiptaskbar kontact --iconify
#sleep 10 && kstart --skiptaskbar nixnote2
sc-deskstop.py start
ktorrent && wmctrl -c "ktorrent"
