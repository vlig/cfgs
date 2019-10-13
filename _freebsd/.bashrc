# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=vim
export EDITOR='vi -e'
export LESS='-RMs +Gg'
#export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nmap q :q<cr>' -"
#export MANPAGER="/usr/local/bin/most -s"
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
alias ls='ls -hF'
alias la='ls -A'
alias ll='ls -Al'
alias grep="grep --color"

alias bashrc='$VISUAL ~/.bashrc && . ~/.bashrc'
alias path='echo -e ${PATH//:/\\n}'

UU='\[\e[1;32m\]'; WU='\[\e[0;31m\]'; _U='\[\e[0;32m\]'
US='\[\e[1;31m\]'; WS='\[\e[0;31m\]'; _S='\[\e[0;31m\]'
export      PS1="${UU}\u ${WU}\w ${UU}$ ${_U}"
export SUDO_PS1="${US}\u ${WS}\w ${US}# ${_S}"
trap 'printf "\e[0m" "$_"' DEBUG

# Display a random cookie on each login
if [ -x /usr/bin/fortune ] ; then echo -- && /usr/bin/fortune freebsd-tips ; fi
