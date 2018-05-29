# load antibody
source ~/.zsh-plugins.sh

export PATH=~/bin:/usr/local/bin:$PATH
export EDITOR=vim

# Share your history across all your terminal windows
setopt share_history

# One less tab to get the completion behavior I like
# setopt MENU_COMPLETE

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Rerun the last command and capture its output to a tempfile. Open the tempfile
# in $EDITOR and afterward, if the file is changed, execute it.
#
# Useful for manipulating the output of things like `git status`.
ugh()
{
    tmpfile=$(mktemp)
    eval `fc -ln -1` > $tmpfile
    MD5=$(md5 $tmpfile)
    $EDITOR "$tmpfile"
    [[ $MD5 != $(md5 $tmpfile) ]] && zsh "$tmpfile"
    rm "$tmpfile"
}

# Machine specific configs
source "$HOME/.localrc.zsh"
