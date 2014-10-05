export GOPATH="$HOME/dev/go"

export PATH="/bin:$PATH"
export PATH="/sbin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.config/bin:$PATH"

if [[ LOCATION == "home" ]]; then
  export PATH="/usr/texbin:$PATH"
  export PATH="/Library/Ruby/Gems/1.8/bin:$PATH"
  export PATH="/Applications/Racket v5.3.3/bin:$PATH"
  export PATH="/Users/chris/Dropbox/Development/MarmosetSubmit/bin:$PATH"
  export PATH="$GOPATH/bin:$PATH"
fi
