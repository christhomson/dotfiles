PROMPT='%{$fg[cyan]%}$MACHINE_NAME%{$reset_color%} %{$fg[magenta]%}→%{$reset_color%} %{$fg[yellow]%}%c: %{$reset_color%}'

# Git
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="⚑"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNMERGED="▾"

if [[ $LOCATION == "school" ]]; then
  # Git is slow on the UW CS servers.
  function git_prompt_info() { }
fi

if [[ -z $timer_show ]]; then
  timer_show=0
fi

RPROMPT='%{$fg[cyan]%}${timer_show}s %{$fg[yellow]%}%p$USER@$(git_prompt_info)'

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    unset timer
  fi
}
