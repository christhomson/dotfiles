# dotfiles

To setup a new machine:
```
bash <(curl -sSL https://github.com/christhomson/dotfiles/raw/master/bootstrap.sh)
```

This will install [Homebrew](http://brew.sh) (if on a Mac) and [Git](http://git-scm.com), clone this repo into ~/.dotfiles, and link all of the dotfiles into their proper locations. It will also install any external dependencies ([oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), [Vim bundles](https://github.com/gmarik/vundle)).
