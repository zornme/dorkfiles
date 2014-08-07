which rbenv &> /dev/null && eval "$(rbenv init -)"
which brew &> /dev/null && [[ -f `brew --prefix`/etc/bash_completion ]] && source `brew --prefix`/etc/bash_completion
[[ -r ~/perl5/perlbrew/etc/bashrc ]] && source ~/perl5/perlbrew/etc/bashrc
[[ -r /usr/local/share/python/virtualenvwrapper.sh ]] && source /usr/local/share/python/virtualenvwrapper.sh
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
[[ -r ~/.bashrc ]] && source ~/.bashrc
