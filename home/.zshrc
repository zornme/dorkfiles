# load zgen
source "${HOME}/.homesick/repos/dorkfiles/zgen/zgen.zsh"

if which rbenv > /dev/null;
    then eval "$(rbenv init -)"
fi

[[ -f "$HOME/.path.sh"  ]] && source "$HOME/.path.sh"
[[ -f "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm"
[[ -f "/usr/local/share/python/virtualenvwrapper.sh"  ]] && source "/usr/local/share/python/virtualenvwrapper.sh"
[[ -f "$HOME/perl5/perlbrew/etc/bashrc"  ]] && source "$HOME/perl5/perlbrew/etc/bashrc"

source `brew --prefix 2> /dev/null`/etc/autojump.sh &> /dev/null

export PATH=~/bin:/usr/local/bin:$PATH
export EDITOR=vim

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

# Correct spelling for commands
setopt correct

# Share your history across all your terminal windows
setopt share_history

# One less tab to get the completion behavior I like
setopt MENU_COMPLETE

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

DISABLE_AUTO_TITLE="true"

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/sorin

    # save all to init script
    zgen save
fi
