#!/bin/bash

ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/ruby/irbrc ~/.irbrc
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall

source ~/.zshrc
