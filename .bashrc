# return if shell isn't interactive
[ -z "$PS1" ] && return

if [ $TERM != "hp" ]; then
  PS1='\[\033[32m\]\u@\h \[\033[31m\]\w \$ \[\033[00m\]'
fi

if [ -d ~/bin ]; then
  # add ~/bin to the path if it exists
  export PATH=:~/bin:$PATH
fi

if [ -d /usr/local/bin ] && [ -d /usr/local/sbin ]; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  export MANPATH=$MANPATH:/usr/local/man
fi

if [ -d /opt/local/bin ] && [ -d /opt/local/sbin ]; then
  # add macports to the path if it exists
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=$MANPATH:/opt/local/man
fi

if [ X$TERM_PROGRAM = X"Apple_Terminal" ]; then
  alias ls='ls -G'
elif [ $TERM = "hp" ]; then
  alias ls='ls -F'
else
  alias ls='ls --color=auto'
fi

alias ll='ls -hl'
export EDITOR=vim

if [ -d fortune ]; then
  fortune ~/.fortunes/fortunes
fi
