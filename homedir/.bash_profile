clear
if [[ $TERM != screen ]]; then
        cat /etc/motd
        [[ -x /usr/bin/screenfetch ]] && screenfetch
        [[ -x /usr/bin/fortune ]] && echo -- && fortune freebsd-tips
fi
[[ -f ~/.bashrc ]] && . ~/.bashrc
screenfetch -w

