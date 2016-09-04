# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM=xterm-256color
# export PAGER='less -s -M +Gg'
# export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nmap q :q<cr>' -"
export PAGER="/usr/local/bin/most -s"
export EDITOR=vim
export HISTCONTROL=ignoreboth
export CLICOLOR="YES"
DIR=Ex
SYM_LINK=Gx
SOCKET=Fx
PIPE=dx
EXE=Cx
BLOCK_SP=Dx
CHAR_SP=Dx
EXE_SUID=hb
EXE_GUID=ad
DIR_STICKY=Ex
DIR_WO_STICKY=Ex
export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"

alias rm='rm -i'
alias ls='ls -F'
alias less=$PAGER
alias grep="grep --color"

#PS1="\[\e[1;37m\]\D{%k:%M} \[\e[32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w \[\e[1;32m\]$ \[\e[0;32m\]"
UCOLOR='\[\e[32m\]'
SYMBOL='\[\e[1;32m\]\$'
[ $UID -eq 0 ] && ( UCOLOR='\[\e[31m\]' ; SYMBOL='\[\e[31m\]\#')
PS1="${UCOLOR}\u \[\e[1;34m\]\w ${UCOLOR}${SYMBOL} \[\e[0m\]"
export PS1; trap 'printf "\e[0m" "$_"' DEBUG
