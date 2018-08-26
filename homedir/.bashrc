#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export TERM=xterm-256color
export PATH="/usr/lib/ccache/bin/:$PATH"
export HISTCONTROL=ignoreboth
export LESS='-RMs +Gg'
#export LESS='-RMs +Gg --no-init'    # do not clear the screen after quit less
export LESSOPEN='|pygmentize -g %s'
export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
#export PAGER='/usr/share/vim/vim74/macros/less.sh'
#export MANPAGER=/usr/bin/less
#export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nmap q :q<cr>' -"
#export MANPAGER="col -b | vim -c 'set ft=man nonu nomod nolist' -"
#export MANPAGER="/bin/sh -c \"unset MANPAGER;col -b -x | \
#		view -R \
#		-c 'set ft=man nomod nolist' \
#		-c 'set nonumber' \
#		-c 'map q :q<CR>' \
#		-c 'map <SPACE> <C-F>' -c 'map b <C-U>' \
#		-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

alias bashrc='$EDITOR ~/.bashrc && . ~/.bashrc'
alias path='echo -e ${PATH//:/\\n}'
alias rm='rm -i'
alias ls='ls -hF --color=always'
alias ll='ls -lA'
alias la='ls -A'
alias dir='dir --color=always'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias dmesg='dmesg --color=always'
#alias df='df -h'
#alias du='du -h'
#alias mount='mount | column -t'

alias kde-startup='$EDITOR ~/.config/autostart-scripts/startup.sh'
alias kde-shutdown='$EDITOR ~/.config/plasma-workspace/shutdown/shutdown.sh'
alias kde-pre-startup='$EDITOR ~/.config/plasma-workspace/env/pre-startup.sh'

shopt -s histappend
PROMPT_COMMAND='history -a; history -n'

#PS1='[\u@\h \W]\$ '
#PS1="\[\e[1;37m\]\D{%k:%M} \[\e[32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w \[\e[1;32m\]$ \[\e[0;32m\]"
DATE_COLOR="\[\e[1;37m\]"
USER_COLOR="\[\e[32m\]"
HOST_COLOR="\[\e[0m\]"
PWD_COLOR="\[\e[1;34m\]"
SYMBOL="\[\e[1;32m\]$"
INPUT_COLOR="\[\e[0;32m\]"
LINE_VERT="\342\224\200"
LINE_CORN="\342\224\224"
LINE_COLOR="\[\e[0;37m\]"
if [[ ${EUID} -eq 0 ]]; then
	USER_COLOR="\[\e[1;31m\]"
	SYMBOL="\[\e[1;31m\]#"
fi
PS1="$DATE_COLOR\D{%k:%M} $USER_COLOR\u$HOST_COLOR@\h $PWD_COLOR\w \n$LINE_COLOR$LINE_CORN$LINE_VERT $SYMBOL $INPUT_COLOR"
trap 'printf "\e[0m" "$_"' DEBUG

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
   . /usr/share/bash-completion/bash_completion
fi

export WINEPREFIX=$HOME/wines/win32
export WINEARCH=win32
#export WINEDLLOVERRIDES=winemenubuilder.exe=d
if [[ ${EUID} -ne 0 ]]; then
	if [[ -f ~/.bash_aliases-wine ]]; then
		. ~/.bash_aliases-wine
	fi
fi

#export SAL_USE_VCLPLUGIN=gtk3    # libreoffice
export KWIN_TRIPLE_BUFFER=1

man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
	LESS_TERMCAP_md=$'\E[01;38;5;74m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[38;5;246m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[04;38;5;146m' \
	man "$@"
}
