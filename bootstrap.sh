#!/usr/bin/env bash

if [[ `uname` == "Darwin" ]]; then
  MAC_OS_X=1
elif [[ `uname` == "Linux" ]]; then
  LINUX=1
fi

echo "We need some information to setup your SSH key and Git config."
read -p "What's your name? " name
read -p "What's your email address? " email
read -p "What's your GitHub username? " github_username

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

if ! [[ `git --version >/dev/null 2>&1` ]]; then
  echo "Git is already installed. Awesome."
else
  if [[ -n $MAC_OS_X ]]; then
    if ! [[ `brew -v >/dev/null 2>&1` ]]; then
      echo "Homebrew is already installed. Let's move on!"
    else
      echo "Installing Homebrew."
      ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi

    echo "Installing git with brew."
    brew install git
  elif [[ -n $LINUX ]]; then
    echo "Installing git-core with apt-get (sudo permission required)."
    sudo apt-get install git-core
  fi
fi

echo "Cloning dotfiles into ~/.config."
git clone git@github.com:christhomson/dotfiles ~/.config

echo "Linking dotfiles."
ln -s ~/.config/git/config ~/.gitconfig
ln -s ~/.config/ssh/config ~/.ssh/config
ln -s ~/.config/vim/vimrc ~/.vimrc

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
      else
        # install fish from source
        cd ~
        mkdir usr
        curl http://fishshell.com/files/2.1.0/fish-2.1.0.tar.gz > ~/fish.tar.gz
        tar -zxvf ~/fish.tar.gz
        absolute_home=`pwd`
        cd fish-2.1.0/
        ./configure --prefix=$absolute_home/usr
        make
        make install
      fi
      break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

while true; do
  read -p "Do you want zsh? " zsh_yn
  case $zsh_yn in
    [Yy]* )
      echo "Installing oh-my-zsh."
      curl -sSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
      rm -f ~/.zshrc
      rm -rf ~/.oh-my-zsh/custom
      ln -s ~/.config/zsh/custom ~/.oh-my-zsh/custom
      ln -s ~/.config/zsh/zshrc ~/.zshrc 
      ln -s ~/.config/zsh/chris-arrow.zsh-theme ~/.oh-my-zsh/themes/chris-arrow.zsh-theme
      break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "Installing Vundle, and installing bundles that are described in .vimrc."
git clone git@github.com:gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

echo "All done!"

if [[ $fish_yn =~ [Yy]* ]]; then
  echo "You'll need to change your default shell to fish yourself."
  fish
elif
  zsh
fi
