if [[ `uname` == "Darwin" ]]; then
  MAC_OS_X=1
elif [[ `uname` == "Linux" ]]; then
  LINUX=1
fi

mkdir -p ~/.ssh
ssh-keygen -t rsa -C "chris@cthomson.ca"
cat ~/.ssh/id_rsa.pub
echo "Please visit https://github.com/settings/ssh to add it."

if [[ MAC_OS_X ]]; then
  pbcopy < ~/.ssh/id_rsa.pub
  echo "Your public key is on your clipboard."
  open "https://github.com/settings/ssh#add"
fi

echo "Press enter to continue once you've added your SSH key to your GitHub account."
read

if [[ MAC_OS_X ]]; then
  echo "Installing Homebrew."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  echo "Installing git with brew."
  brew install git
elif [[ LINUX ]]; then
  echo "Installing git-core with apt-get (sudo permission required)."
  sudo apt-get install git-core
fi

git clone git@github.com:christhomson/dotfiles ~/.dotfiles

ln -s ~/.dotfiles/git/config ~/.gitconfig
ln -s ~/.dotfiles/ssh/config ~/.ssh/config
ln -s ~/.dotfiles/zsh/profile ~/.zshrc
