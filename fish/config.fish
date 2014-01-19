bind \e\[1\;5C forward-word
bind \e\[1\;5D backward-word

set fish_greeting ""

# aliases
alias ..='cd ..'
alias b='bundle'
alias bs='bundle exec rails server'
alias bake='bundle exec rake'
alias gs='git status'
alias gst='git stash'
alias gsa='git stash apply'
alias gd='git diff'

# path
set PATH ~/bin $PATH

# rbenv
if test -d $HOME/.rbenv
  set PATH $HOME/.rbenv/bin $PATH
  set PATH $HOME/.rbenv/shims $PATH
  rbenv rehash >/dev/null ^&1
end