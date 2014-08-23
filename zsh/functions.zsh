common_commands() {
  history |
  sed 's/^ \+//;s/  / /' |
  cut -d' ' -f2- |
  awk '{ count[$0]++ } END { for (i in count) print count[i], i }' |
  sort -rn |
  head -50
}
