# return if shell isn't interactive
[ -z "$PS1" ] && return

# ~ ⚡
PS1='\[\033[32m\]\w \[\033[33m\]⚡ \[\033[00m\]'

# Extend path
if [ -d ~/bin ]; then
  export PATH=:~/bin:$PATH
fi

if [ -d /usr/local/share/python ]; then
  export PATH=:/usr/local/share/python:$PATH
fi

if [ -d /usr/local/bin ] && [ -d /usr/local/sbin ]; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  export MANPATH=$MANPATH:/usr/local/man
fi

# TODO find less hacky detection method
if [ X$TERM_PROGRAM = X"Apple_Terminal" ]; then
  export LS_FLAGS="-G"
fi

ls --color=auto /dev/null > /dev/null 2>&1
if [ $? -eq 0 ]; then
  export LS_FLAGS="--color=auto $LS_FLAGS"
fi

ls --human-readable /dev/null > /dev/null 2>&1
if [ $? -eq 0 ]; then
  export LS_FLAGS="--human-readable $LS_FLAGS"
fi

alias ls="ls $LS_FLAGS"
alias ll="ls -l"
alias ackf="ack --follow"
export EDITOR=vim
