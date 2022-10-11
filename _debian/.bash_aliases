export EDITOR=/usr/bin/vim
alias bashrc='$EDITOR ~/.bashrc && . ~/.bashrc'
alias upgrade='sudo apt update && sudo apt full-upgrade'
alias install='sudo apt install'
#alias mount='mount | column -t'

[[ -z "$SSH_AGENT_PID" ]] && eval $(ssh-agent -s)
