alias ..='cd ..'

alias b='bundle'
alias be='bundle exec'
alias bx='bundle exec'
alias bc='bundle exec rails console'
alias bs='bundle exec rails server'
alias bi='bundle install'
alias bo='bundle open'
alias bu='bundle update'
alias bake='bundle exec rake'
alias bt='bundle exec rake test'
alias bails='bundle exec rails'
alias ss='script/server'

alias gs='git st'
alias gst='git stash'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gd='git diff'
alias gbrt='git branch-timeline'
alias gap='git add -p'
alias grc='git rebase --continue'
alias grh='git reset --hard'

alias vi='vim'
alias v='vi .'

alias nm='nodemon'

# Pretty print JSON.
alias ppj='python -mjson.tool'

# Use OpenDNS to tell us our external IP.
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

# Merge PDF files.
if [ $OSX ]; then
  alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
fi

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Don't log these in my history.
alias ls=' ls -G'
alias cd=' cd'
