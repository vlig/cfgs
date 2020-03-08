# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=10000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
shopt -s cmdhist
shopt -s cdspell
shopt -s dirspell
PROMPT_COMMAND='history -a; history -n'

export PATH="/usr/lib/ccache/bin/:$PATH"
export LESS='-RMs +Gg'
export LESSOPEN='|pygmentize -g %s'
export PAGER=/usr/bin/less
export VISUAL=/usr/bin/vim
export EDITOR='/usr/bin/vim -e'

alias bashrc='$VISUAL ~/.bashrc && . ~/.bashrc'
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
alias git-agent='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/github_rsa'
alias kde-startup='$EDITOR ~/.config/autostart-scripts/startup.sh'
alias kde-shutdown='$EDITOR ~/.config/plasma-workspace/shutdown/shutdown.sh'
alias kde-pre-startup='$EDITOR ~/.config/plasma-workspace/env/pre-startup.sh'

DU="\[\e[1;37m\]"; UU="\[\e[0;32m\]"; HU="\[\e[0m\]"; WU="\[\e[1;34m\]"; _U="\[\e[0;32m\]"
DS="\[\e[1;37m\]"; US="\[\e[1;31m\]"; HS="\[\e[0m\]"; WS="\[\e[1;34m\]"; _S="\[\e[0;31m\]"
LINE="\[\e[0;37m\]"
LCRN="\342\224\224"
LVRT="\342\224\200"
export      PS1="$DU\D{%k:%M} $UU\u$HU@\h $WU\w \n$LINE$LCRN$LVRT $UU$ $_U"
export SUDO_PS1="$DS\D{%k:%M} $US\u$HS@\h $WS\w \n$LINE$LCRN$LVRT $US# $_S"
trap 'printf "\e[0m" "$_"' DEBUG

[[ -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && . /usr/share/doc/pkgfile/command-not-found.bash

export WINEPREFIX=$HOME/wines/win32
export WINEARCH=win64
#[[ -f ~/.bash_aliases-wine ]] && . ~/.bash_aliases-wine
alias wine-rec="WINEARCH=win64 WINEPREFIX=~/wines/rec $@"
alias reaper-update="WINEARCH=win64 WINEPREFIX=~/wines/rec wine start /unix $@"
alias steam-wine="WINEARCH=win64 WINEPREFIX=~/wines/steam wine ~/wines/steam/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox"
#alias steam-wine="WINEARCH=win64 WINEPREFIX=~/wines/steam WINEDEBUG=-all wine ~/wines/steam/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox -tcp >/dev/null 2>&1 &"

#export KWIN_TRIPLE_BUFFER=1

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
