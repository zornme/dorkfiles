# return if shell isn't interactive
[ -z "$PS1" ] && return

# ~ ⚡
PS1='\[\033[32m\]\w \[\033[33m\]⚡ \[\033[00m\]'

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

eval "$(rbenv init - &> /dev/null)"
source "$HOME/.rvm/scripts/rvm" &> /dev/null
source /usr/local/share/python/virtualenvwrapper.sh &> /dev/null
source `brew --prefix &> /dev/null`/etc/autojump.sh &> /dev/null
source `brew --prefix &> /dev/null`/etc/bash_completion &> /dev/null
source ~/perl5/perlbrew/etc/bashrc &> /dev/null

export PATH=~/bin:$PATH
export EDITOR=vim

# For any local unversioned modifications
[[ -s "$HOME/.bashrc_local" ]] && source "$HOME/.bashrc_local"
