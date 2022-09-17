#if(!$?prompt)exit
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

force_color_prompt=yes

if [ -f /etc/skel/.bashrc ]; then
    . /etc/skel/.bashrc
fi

if [ -x /usr/bin/dircolors ]; then
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# My tweaks

setupcon 2>/dev/null
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'

export LESS='-RMs +Gg'
#export LESSOPEN='|pygmentize -g %s' # requires (python-)pygments installation
export PAGER='less'
alias ls='ls -hF'
alias ll='ls -l'
alias la='ls -la'
alias rm='rm -i'
alias path='echo -e ${PATH//:/\\n}'

USER_COLOR="\[\e[1;32m\]"
USER_ENTER="\[\e[0;32m\]"
USER_SYMBOL="$"
if [[ ${EUID} -eq 0 ]]; then
	USER_COLOR="\[\e[1;31m\]"
	USER_ENTER="\[\e[0;31m\]"
	USER_SYMBOL="#"
fi
PS1="\[\e[1;37m\]\D{%k:%M} $USER_COLOR\u\[\e[0m\]@\h \[\e[1;34m\]\w \n\[\e[0;37m\]\342\224\224\342\224\200 $USER_COLOR$USER_SYMBOL $USER_ENTER"
trap 'printf "\e[0m" "$_"' DEBUG
