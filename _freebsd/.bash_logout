unset PS1
clear
##[[ ! -z "$SSH_AGENT_PID" ]] && ssh-agent -k || echo No\ ssh-agent\ running
#[[ ! -z "$SSH_AGENT_PID" ]] && pid=$SSH_AGENT_PID && unset SSH_AUTH_SOCK && unset SSH_AGENT_PID && \
#echo Agent\ pid\ $pid\ killed || \
#echo No\ ssh-agent\ running

