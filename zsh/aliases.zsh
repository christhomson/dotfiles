alias ..='cd ..'

alias b='bundle'
alias be='bundle exec'
alias bake='bundle exec rake'
alias bc='bundle exec rails console'
alias bs='bundle exec rails server'
alias bi='bundle check || bundle install --jobs 4'
alias bo='bundle open'
alias bu='bundle update'
alias t='bundle exec spring testunit'

alias s='dev server'
alias u='dev up'

alias dup='dev update && dev up'
alias dc='dev console'
alias ds='dev server'
alias dt='dev test'

alias ga='git add'
alias gs='git status'
alias gst='git stash'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gd='git diff'
alias gdc='git diff --cached'
alias gap='git add -p'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
alias grh='git reset --hard'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gu='git unstage'
alias guc='git reset --soft HEAD~1'
alias gbt='git branch-timeline'
alias gpo='git pull origin'
alias gpom='git pull origin master'
alias gn='git update-master; bundle install; git checkout -b'
alias gm='git checkout master'
alias gr='git rebase'
alias grm='git rebase master'
alias gch='git changes'

alias cop='dirtycop --branch'

alias fos='bundle exec spring stop'

alias sso='heroku login --sso'

alias vi='vim'
alias v='vi'

alias gf='fg'

alias latex='latexmk -pvc -pdf'

alias reload='source ~/.zshrc'

# Pretty print JSON.
alias json='python -mjson.tool'

# Highlighted cat.
alias hcat="pygmentize -g -O style=rrt -f terminal256"

# Use OpenDNS to tell us our external IP.
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

# Merge PDF files.
if [ $OSX ]; then
  alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
fi

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

alias ls='ls -G'

# Don't log these in my history.
alias cd=' cd'
