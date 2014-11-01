#!/usr/bin/env bash
set -x

create_directories() {
  mkdir -p ~/dev/go
}

ssh_configuration() {
  if [[ ! -f ~/.ssh/id_rsa ]]; then
    read -p "An email address is needed for your SSH key. What is it? " email
    ssh-keygen -t rsa -C "$email"
    cat ~/.ssh/id_rsa.pub
    echo "Please visit https://github.com/settings/ssh to add this key to your account."
    if ! [[ `which pbcopy &>/dev/null` ]]; then
      pbcopy < ~/.ssh/id_rsa.pub
      echo "Your public key is on your clipboard."
    fi

    if ! [[ `which open &>/dev/null` ]]; then
      open "https://github.com/settings/ssh"
    fi
  fi
}

homebrew_source_install() {
  if [[ `which brew &>/dev/null` ]]; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  fi
}

apt_update() {
  sudo apt-get update
}

homebrew_update() {
  brew update
}

git_apt_install() {
  if [[ `which git &>/dev/null` ]]; then
    sudo apt-get install git-core
  fi
}

git_homebrew_install() {
  if [[ `which git &>/dev/null` ]]; then
    brew install git
  fi
}

git_source_install() {
  if [[ `which git &>/dev/null` ]]; then
    cd ~
    mkdir -p usr
    curl https://github.com/git/git/archive/v1.8.5.3.tar.gz > git.tar.gz
    tar -zxf git.tar.gz
    cd ~/git-1.8.5.3
    make prefix=$ABSOLUTE_HOME/usr all
    make prefix=$ABSOLUTE_HOME/usr install
    cd ~
    rm -rf git-1.8.5.3
  fi
}

clone_dotfiles_repo() {
  if [[ -d "~/.config" ]]; then
    git clone --recursive git://github.com/christhomson/dotfiles.git ~/.config
  fi
}

set_machine_name() {
  if [ -z "$MACHINE_NAME" ]; then
    read -p "Please enter a name for this machine: " machine_name
    echo "export MACHINE_NAME=\"$machine_name\"" > ~/.config/zsh/machine.zsh
  fi
}

git_configuration() {
  name=`git config --global user.name`
  email=`git config --global user.email`

  if [ -z "$name" ]; then
    read -p "Git needs your full name. What is it? " name
    git config --global user.name "$name"
  fi

  if [ -z "$email" ]; then
    read -p "Git needs your public email address. What is it? " email
    git config --global user.email "$email"
  fi
}

ag_apt_install() {
  if [[ `which ag &>/dev/null` ]]; then
    sudo apt-get install silversearcher-ag
  fi
}

ag_homebrew_install() {
  if [[ `which ag &>/dev/null` ]]; then
    brew install the_silver_searcher
  fi
}

ag_source_install() {
  if [[ `which ag &>/dev/null` ]]; then
    cd ~
    mkdir -p usr
    git clone git://github.com/ggreer/the_silver_searcher.git
    cd the_silver_searcher
    ./build.sh --prefix=$ABSOLUTE_HOME/usr
    make install
    cd ~
    rm -rf the_silver_searcher
  fi
}

link_dotfiles() {
  # TODO - check if same
  ln -s ~/.config/git/config ~/.gitconfig
  ln -s ~/.config/ssh/config ~/.ssh/config
  ln -s ~/.config/vim/vimrc ~/.vimrc
  ln -s ~/.config/vim/gvimrc ~/.gvimrc
  ln -s ~/.config/zsh/zshrc ~/.zshrc
  ln -s ~/.config/maid ~/.maid

  mkdir -p ~/.subversion
  ln -s ~/.config/svn/config ~/.subversion/config
}

vundle_git_install() {
  mkdir -p ~/.vim/bundle

  if [[ ! -d "~/.vim/bundle/vundle" ]]; then
    git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  fi
  vim +BundleInstall +qall
  vim +BundleClean +qall
}

chruby_homebrew_install() {
  brew install chruby
}

ruby-install_homebrew_install() {
  brew install ruby-install
}

gems_install() {
  if [[ `gem list -i awesome_print` == "false" ]]; then
    gem install awesome_print
  fi

  if [[ `gem list -i git-smart` == "false" ]]; then
    gem install git-smart
  fi

  if [[ `gem list -i what_methods` == "false" ]]; then
    gem install what_methods
  fi
}

fix_zsh_config_for_vim() {
  if [[ -f /etc/zshenv ]]; then
    sudo mv /etc/zshenv /etc/zshrc
  fi
}

provision_mac_os_x() {
  create_directories
  ssh_configuration
  homebrew_source_install
  homebrew_update
  git_homebrew_install
  clone_dotfiles_repo
  link_dotfiles
  set_machine_name
  git_configuration
  ag_homebrew_install
  vundle_git_install
  chruby_homebrew_install
  ruby-install_homebrew_install
  gems_install
  fix_zsh_config_for_vim
}

provision_linux_sudo() {
  create_directories
  ssh_configuration
  apt_update
  git_apt_install
  clone_dotfiles_repo
  link_dotfiles
  set_machine_name
  git_configuration
  ag_apt_install
  vundle_git_install
  gems_install
}

provision_linux() {
  create_directories
  ssh_configuration
  git_source_install
  clone_dotfiles_repo
  link_dotfiles
  set_machine_name
  git_configuration
  ag_source_install
  vundle_git_install
  gems_install
}

if [[ -f ~/.config/zsh/machine.zsh ]]; then
  source ~/.config/zsh/machine.zsh
fi

if [[ `uname` == "Darwin" ]]; then
  provision_mac_os_x
elif [[ "$1" == "--sudo" ]]; then
  provision_linux_sudo
else
  provision_linux
fi
