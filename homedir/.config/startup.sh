#!/bin/sh
plaympeg ~/Music/logonsound/* </dev/null &
mount ~/mnt/yadisk 
kstart --skiptaskbar kontact --iconify && sleep 10 && wmctrl -c Kontact
#sleep 5 && wmctrl -c KTorrent
sleep 5 && wmctrl -c Franz
sleep 5 && conky -d
sc-deskstop.py start

#xinput --set-prop 9 'libinput Accel Profile Enabled' 1, 0
#mplayer -really-quiet -vc null -vo null ~/Music/logonsound/* </dev/null &
#sleep 10 && kontact && sleep 2 && qdbus org.kde.kontact /kontact/MainWindow_1 org.qtproject.Qt.QWidget.hide
#sleep 10 && kstart --skiptaskbar nixnote2
