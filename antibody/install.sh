#!/bin/sh

# Install via brew install getantibody/tap/antibody
antibody bundle < ~/.dotfiles/antibody/zsh-plugins.txt > ~/.zsh-plugins.sh
antibody update
