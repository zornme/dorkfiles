# load antibody
source ~/.zsh-plugins.sh

export PATH=~/bin:/usr/local/bin:$PATH
export EDITOR=vim

# Bash style command line editing with ^c^e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Use ctrl+enter to accept and execute autosuggestions
bindkey '^{' autosuggest-accept
bindkey '^}' autosuggest-execute

# Share your history across all your terminal windows
setopt share_history

# One less tab to get the completion behavior I like
setopt MENU_COMPLETE

# Tweak ^w behavior
export WORDCHARS='*?.[]~=&;!#$%^(){}<>'

# Enable tab completions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

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
