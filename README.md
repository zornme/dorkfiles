# Installation

```
git clone --recursive git@github.com:zornme/dorkfiles.git ~/.dotfiles
brew install stow
```

## Vim

```
# Neocomplete requires lua
brew install vim --with-lua
brew install macvim --with-lua

cd ~/.dotfiles
stow vim
```

Afterward, run `:PluginInstall` in Vim.

## Zsh

```
brew install getantibody/tap/antibody
brew install fasd
brew install zsh

# Set zsh as the defualt shell
echo `which zsh` | sudo tee -a /etc/shells
chsh -s $(which zsh)

cd ~/.dotfiles
bash antibody/install.sh
stow zsh
```

## Git configuration

Contains my gitconfig and https://tbaggery.com/2011/08/08/effortless-ctags-
with-git.html

```
cd ~/.dotfiles
stow git
```