#!/bin/bash

ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/ruby/irbrc ~/.irbrc
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/git/config ~/.gitconfig

if [ $SPIN ]; then
  git config --global user.name "Chris Thomson"
  git config --global user.email "chris.thomson@shopify.com"

  sudo apt-get install -y cloc ctags fzf silversearcher-ag tree
fi

if [ $OSX ]; then
  brew install mosh
fi

vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall

