common_commands() {
  history |
  sed 's/^ \+//;s/  / /' |
  cut -d' ' -f2- |
  awk '{ count[$0]++ } END { for (i in count) print count[i], i }' |
  sort -rn |
  head -50
}

# Override rake and rails methods to automatically use `zeus` or `bundle exec`.
rake() {
  if [ -S '.zeus.sock' ]; then
    zeus rake ${*:1}
  elif [ -f 'Gemfile' ]; then
    bundle exec rake ${*:1}
  else
    rake ${*:1}
  fi
}

rails() {
  if [[ -S '.zeus.sock' && ($1 = 's' || $1 = 'server' || $1 = 'g' || $1 = 'generate' || $1 = 'd' || $1 = 'destroy' || $1 = 'c' || $1 = 'console' || $1 = 'r' || $1 = 'runner') ]]; then
    zeus $1 ${*:2}
  elif [ -f 'Gemfile' ]; then
    bundle exec rails $1 ${*:2}
  else
    echo "I don't know what to do. You aren't using Zeus or Bundler."
    return 1
  fi
}
