[[ $- != *i* ]] && return

export VISUAL=vim
export EDITOR='vi -e'
export LESS='-RMs +Gg'
#export PAGER='/usr/bin/less'
export HISTCONTROL=ignoreboth
shopt -s histappend ; PROMPT_COMMAND='history -a; history -n'

export CLICOLOR_FORCE=1
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
alias ll='ls -l'
alias la='ls -lA'
alias sudo='sudo '
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias bashrc="$VISUAL ~/.bashrc && . ~/.bashrc"
alias path='echo -e ${PATH//:/\\n}'
#alias git-agent='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/github_rsa'
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

DATE='\[\e[1;37m\]'
LINE='\[\e[0;37m\]'
LINE_VERT='\342\224\200'
LINE_CORN='\342\224\224'
WU='\[\e[0;00m\]'
if [[ ${EUID} != 0 ]]; then
	UU='\[\e[1;32m\]'; _U='\[\e[0;32m\]'; else
	UU='\[\e[1;31m\]'; _U='\[\e[0;31m\]'
fi
export PS1="${DATE}\D{%k:%M} ${UU}\u${_U}@\H ${WU}\w \n${LINE}${LINE_CORN}${LINE_VERT} ${UU}$ ${_U}"
#US='\[\e[1;31m\]'; WS='\[\e[0;00m\]'; _S='\[\e[0;31m\]'
#export SUDO_PS1="${DATE}\D{%k:%M} ${US}\u${_S}@\H ${WS}\W \n${LINE}${LINE_CORN}${LINE_VERT} ${US}# ${_S}"
trap 'printf "\e[0m" "$_"' DEBUG

[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	. /usr/local/share/bash-completion/bash_completion.sh

man() {
	env LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;38;5;74m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[38;5;246m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[04;38;5;146m' \
	man "$@"
}
