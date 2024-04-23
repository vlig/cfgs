#clear
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $TERM =~ ^(screen|tmux)* ]] && \
echo "\$TERM = $TERM" || \
screenfetch

trap 'test -n "$SSH_AGENT_PID" && eval $(/usr/bin/ssh-agent -k)' 0
