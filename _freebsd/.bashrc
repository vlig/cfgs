[[ $- != *i* ]] && return

export VISUAL=vim
export EDITOR='vi -e'
export LESS='-RMs +Gg'
export HISTCONTROL=ignoreboth
export CLICOLOR_FORCE=1
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'
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
alias ls='ls -hFG'
alias la='ls -A'
alias ll='ls -Al'
alias grep="grep --color"
alias bashrc='$VISUAL ~/.bashrc && . ~/.bashrc'
alias path='echo -e ${PATH//:/\\n}'

UU='\[\e[1;32m\]'; WU='\[\e[0;00m\]'; _U='\[\e[0;32m\]'
US='\[\e[1;31m\]'; WS='\[\e[0;00m\]'; _S='\[\e[0;31m\]'
export      PS1="${UU}\u${_U}@\H ${WU}\W ${UU}$ ${_U}"
export SUDO_PS1="${US}\u${_S}@\H ${WS}\W ${US}# ${_S}"
trap 'printf "\e[0m" "$_"' DEBUG  # command output still colored in "sudo -s" mode

[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	source /usr/local/share/bash-completion/bash_completion.sh

man() {
	env LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
}
