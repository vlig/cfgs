#!/bin/sh

plaympeg ~/Music/logonsound/* </dev/null &
mount ~/mnt/yadisk 
sc-deskstop.py start
sleep 5 && conky -d

#while [ -z "$(wmctrl -l | grep "Mozilla Thunderbird")" ]; do sleep 0.1; done; wmctrl -c "Mozilla Thunderbird"
#while [ -z "$(wmctrl -l | grep Franz)" ]; do sleep 0.1; done; wmctrl -c Franz

#sleep 10 && /opt/teamviewer/tv_bin/script/teamviewer
#while [ -z $(pidof TeamViewer) ]; do sleep 0.1; done
while [ -z "$(wmctrl -l | grep WhatsApp)" ]; do sleep 0.1; done; wmctrl -c WhatsApp
while [ -z "$(wmctrl -l | grep TeamViewer)" ]; do sleep 0.1; done; wmctrl -c TeamViewer
