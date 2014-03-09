#!/usr/bin/env bash

if [[ `uname` == "Darwin" ]]; then
  MAC_OS_X=1
elif [[ `hostname` =~ linux0[0-9][0-9]\.student\.cs ]]; then
  LINUX_NO_SUDO=1
else
  while true; do
    read -p "Do you have sudo access? " sudo_yn
    case $sudo_yn in
      [Yy]* )
        LINUX_SUDO=1;
        sudo apt-get update
        break;;
      [Nn]* )
        LINUX_NO_SUDO=1
        break;;
      * ) "Please answer yes or no."
    esac
  done
fi

cd ~
ABSOLUTE_HOME=`pwd`

echo "We need some information to setup your SSH key and Git config."
read -p "What's your name? " name
read -p "What's your email address? " email
read -p "What's your GitHub username? " github_username

echo "Generating SSH key (will confirm overwrite if you already have one)..."
mkdir -p ~/.ssh
ssh-keygen -t rsa -C "$email"
cat ~/.ssh/id_rsa.pub
echo "Please visit https://github.com/settings/ssh to add this key to your account."

if [[ -n $MAC_OS_X ]]; then
  pbcopy < ~/.ssh/id_rsa.pub
  echo "Your public key is on your clipboard."
  open "https://github.com/settings/ssh#add"
fi

echo "Press enter to continue once you've added your SSH key to your GitHub account."
read

if ! [[ `which git &>/dev/null` ]]; then
  echo "Git is already installed. Awesome."
else
  if [[ -n $MAC_OS_X ]]; then
    if ! [[ `which brew &>/dev/null` ]]; then
      echo "Homebrew is already installed. Let's move on!"
    else
      echo "Installing Homebrew."
      ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi

    echo "Installing git with brew."
    brew install git
  elif [[ -n $LINUX_SUDO ]]; then
    echo "Installing git-core with apt-get (sudo permission required)."
    sudo apt-get install git-core
  else
    echo "Installing git from source."
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
fi

if ! [[ `which git &>/dev/null` ]]; then
  echo "hub is already installed. Sweet."
else
  echo "Installing hub from source."
  git clone git@github.com:github/hub.git ~/hub
  cd ~/hub
  rake install prefix=$ABSOLUTE_HOME/usr
  cd ~
  rm -rf hub/
fi

echo "Cloning dotfiles into ~/.config."
git clone --recursive git@github.com:christhomson/dotfiles ~/.config

echo "Linking dotfiles."
ln -s ~/.config/git/config ~/.gitconfig
ln -s ~/.config/ssh/config ~/.ssh/config
ln -s ~/.config/vim/vimrc ~/.vimrc
ln -s ~/.config/vim/gvimrc ~/.gvimrc

echo "Configuring Git for $github_username ($name: $email)"
git config --global user.name "$name"
git config --global user.email "$email"
git config --global github.user "$github_username"

while true; do
  read -p "Do you want fish? " fish_yn
  case $fish_yn in
    [Yy]* )
      if [[ -n $MAC_OS_X ]]; then
        brew install fish
      elif [[ -n $LINUX_SUDO ]]; then
        sudo apt-get install fish
      else
        echo "Installing fish from source."
        cd ~
        mkdir -p usr
        curl http://fishshell.com/files/2.1.0/fish-2.1.0.tar.gz > ~/fish.tar.gz
        tar -zxvf ~/fish.tar.gz
        cd fish-2.1.0/
        ./configure --prefix=$ABSOLUTE_HOME/usr
        make
        make install
        cd ~
        rm -rf fish-2.1.0/
        rm fish.tar.gz
      fi
      break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

ln -s ~/.config/zsh/zshrc ~/.zshrc
read -p "Please enter a name for this machine: " machine_name
echo "export MACHINE_NAME=\"$machine_name\"" > ~/.config/zsh/machine.zsh

if ! [[ `which ag &>/dev/null` ]]; then
  echo "ag is already installed."
else
  echo "Installing ag."
  if [[ -n $MAC_OS_X ]]; then
    brew install the_silver_searcher
  elif [[ -n $LINUX_SUDO ]]; then
    sudo apt-get install silversearcher-ag
  else
    cd ~
    mkdir -p usr
    git clone git@github.com:ggreer/the_silver_searcher.git
    cd the_silver_searcher
    ./build.sh --prefix=$ABSOLUTE_HOME/usr
    make install
    cd ~
    rm -rf the_silver_searcher
  fi 
fi

echo "Installing Vundle, and installing bundles that are described in .vimrc."
git clone git@github.com:gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

while true; do
  read -p "Do you want rbenv? " rbenv_yn
  case $rbenv_yn in
    [Yy]* )
      echo "Installing rbenv and rbenv-gem-rehash."
      git clone git@github.com:sstephenson/rbenv.git ~/.rbenv
      git clone git@github.com:sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
      break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no."
  esac
done

zsh
