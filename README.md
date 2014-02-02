# dotfiles

To setup a new machine:
```
bash <(curl -sSL https://github.com/christhomson/dotfiles/raw/master/bootstrap.sh)
```

This will clone this repo into ~/.config, install any dependencies that aren't already installed, and link all the dotfiles into their proper locations.

Currently, these are the dependencies that will be installed:
* [Homebrew](https://github.com/mxcl/homebrew) (if installing onto Mac OS X)
* [Git](http://git-scm.com)
* [Fish shell](http://fishshell.com) [optional]
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (currently this assumes zsh itself is already installed) [optional]
* [Ag](https://github.com/ggreer/the_silver_searcher)
* [Vundle](https://github.com/gmarik/vundle), and [a bunch of Vim bundles](https://github.com/christhomson/dotfiles/blob/master/vim/vimrc)
* [rbenv](https://github.com/sstephenson/rbenv) [optional]

The bootstrap.sh script supports installing these dependencies on Macs, on Linux machines with `sudo` access, and on Linux machines where you don't have `sudo` access.
