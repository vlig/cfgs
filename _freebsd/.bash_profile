clear
[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ $TERM != screen ]]; then
	#cat /etc/motd
	[[ -x /usr/local/bin/screenfetch ]] && screenfetch
	[[ -x /usr/bin/fortune ]] && fortune freebsd-tips
fi
