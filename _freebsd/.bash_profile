clear
if [[ $TERM != screen ]]; then
	cat /etc/motd
	[[ -x /usr/local/bin/screenfetch ]] && screenfetch
	[[ -x /usr/bin/fortune ]] && echo -- && /usr/bin/fortune freebsd-tips
fi
[[ -f ~/.bashrc ]] && . ~/.bashrc
