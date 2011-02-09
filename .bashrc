# return if shell isn't interactive
[ -z "$PS1" ] && return

PS1='\[\033[32m\]\u@\h \[\033[31m\]\w \$ \[\033[00m\]'

if [ -d ~/bin ]; then
  # add ~/bin to the path if it exists
  export PATH=:~/bin:$PATH
fi

if [ -d /opt/local/bin ] && [ -d /opt/local/sbin ]; then
  # add macports to the path if it exists
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=$MANPATH:/opt/local/man
fi

if [ X$TERM_PROGRAM = X"Apple_Terminal" ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias ll='ls -hl'
export EDITOR=vim
fortune ~/.fortunes/fortunes
