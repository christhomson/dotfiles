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
echo "Please visit https://github.com/settings/ssh to add it."

if [[ MAC_OS_X ]]; then
  pbcopy < ~/.ssh/id_rsa.pub
  echo "Your public key is on your clipboard."
  open "https://github.com/settings/ssh#add"
fi

echo "Press enter to continue once you've added your SSH key to your GitHub account."
read

if ! [[ `git --version >/dev/null 2>&1` ]]; then
  echo "Git is already installed. Awesome."
else
  if [[ MAC_OS_X ]]; then
    if ! [[ `brew -v >/dev/null 2>&1` ]]; then
      echo "Homebrew is already installed. Let's move on!"
    else
      echo "Installing Homebrew."
      ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi

    echo "Installing git with brew."
    brew install git
  elif [[ LINUX ]]; then
    echo "Installing git-core with apt-get (sudo permission required)."
    sudo apt-get install git-core
  fi
fi

echo "Cloning dotfiles."
git clone git@github.com:christhomson/dotfiles ~/.dotfiles

echo "Linking dotfiles."
ln -s ~/.dotfiles/git/config ~/.gitconfig
ln -s ~/.dotfiles/ssh/config ~/.ssh/config
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

echo "Configuring Git for $github_username ($name: $email)"
git config --global user.name "$name"
git config --global user.email "$email"
git config --global github.user "$github_username"

echo "Installing oh-my-zsh."
curl -sSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

rm -rf ~/.oh-my-zsh/custom
ln -s ~/.dotfiles/zsh/custom ~/.oh-my-zsh/custom
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/chris-arrow.zsh-theme ~/.oh-my-zsh/themes/chris-arrow.zsh-theme

echo "Installing Vundle, and installing bundles that are described in .vimrc."
git clone https://github.com/gmarik/vundle.git ~/.dotfiles/vim/vundle
vim +BundleInstall +qall
