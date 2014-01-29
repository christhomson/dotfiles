export PATH="/bin:$PATH"
export PATH="/sbin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="~/bin:$PATH"

if [[ LOCATION == "home" ]]; then
  export GOPATH="$HOME/dev/go"
  export PATH="/usr/texbin:$PATH"
  export PATH="/Library/Ruby/Gems/1.8/bin:$PATH"
  export PATH="/Applications/Racket v5.3.3/bin:$PATH"
  export PATH="/usr/local/texlive/2010/bin/universal-darwin:$PATH"
  export PATH="/Users/chris/Dropbox/Development/MarmosetSubmit/bin:$PATH"
  export PATH="$GOPATH/bin:$PATH"
fi
