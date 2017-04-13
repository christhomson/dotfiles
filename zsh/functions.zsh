common_commands() {
  history |
  sed 's/^ \+//;s/  / /' |
  cut -d' ' -f2- |
  awk '{ count[$0]++ } END { for (i in count) print count[i], i }' |
  sort -rn |
  head -50
}

fp() {
  BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
  if [[ $BRANCH_NAME = 'master' ]]
  then
    echo "You just tried to force push master - are you sure that's what you want?"
  else
    git push origin $BRANCH_NAME --force-with-lease
  fi
}
