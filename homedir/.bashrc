#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM=xterm-256color
export PAGER='less -s -M +Gg'
export MANPAGER='less -s -M +Gg'
#export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nmap q :q<cr>' -"
#export MANPAGER="col -b | vim -c 'set ft=man nonu nomod nolist' -"
export EDITOR=/usr/bin/vim

export WINEPREFIX=$HOME/wines/win32
export WINEARCH=win32
#export WINEDLLOVERRIDES=winemenubuilder.exe=d

alias sudo='sudo '
alias rm='rm -i'
alias ls='ls -F --color=always'
alias dir='dir --color=always'
alias grep='grep --color=always'
alias dmesg='dmesg --color=always'
alias less=$PAGER

shopt -s histappend
PROMPT_COMMAND='history -a'

#PS1='[\u@\h \W]\$ '
#PS1="\[\e[1;37m\]\D{%k:%M} \[\e[32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w \[\e[1;32m\]$ \[\e[0;32m\]"
DATE_COLOR="\[\e[1;37m\]"
USER_COLOR="\[\e[32m\]"
HOST_COLOR="\[\e[0m\]"
PWD_COLOR="\[\e[1;34m\]"
SYMBOL="\[\e[1;32m\]$"
INPUT_COLOR="\[\e[0;32m\]"
LINE_VERT="\342\224\200"
LINE_CORN1="\342\224\214"
LINE_CORN2="\342\224\224"
LINE_COLOR="\[\e[0;37m\]"
if [[ ${EUID} -eq 0 ]]; then
	USER_COLOR="\[\e[0;31m\]"
	SYMBOL="\[\e[0;31m\]#"
fi
PS1="$LINE_COLOR$LINE_CORN1$LINE_VERT$DATE_COLOR\D{%k:%M} $USER_COLOR\u$HOST_COLOR@\h $PWD_COLOR\w \n$LINE_COLOR$LINE_CORN2$LINE_VERT $SYMBOL $INPUT_COLOR"
export PS1; trap 'printf "\e[0m" "$_"' DEBUG

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
   . /usr/share/bash-completion/bash_completion
fi

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
 
if [[ ${EUID} -ne 0 ]]; then
	if [[ -f ~/.bash_aliases-wine ]]; then
		. ~/.bash_aliases-wine
	fi
fi
