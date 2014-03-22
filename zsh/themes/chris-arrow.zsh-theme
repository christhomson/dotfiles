PROMPT='%{$fg[cyan]%}$MACHINE_NAME%{$reset_color%} %{$fg[magenta]%}→%{$reset_color%} %{$fg[yellow]%}%c: %{$reset_color%}'

# Git
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="⚑"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNMERGED="▾"

git_prompt_info() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

if [[ -z $elapsed_time ]]; then
  timer_view=""
fi

RPROMPT='%{$fg[cyan]%}${timer_view} %{$fg[yellow]%}%p$USER@'

if [[ $LOCATION == "school" ]]; then
  RPROMPT='%{$fg[cyan]%}${timer_view} %{$fg[yellow]%}%p$USER@'
else
  RPROMPT='%{$fg[cyan]%}${timer_view} %{$fg[yellow]%}%p$USER@$(git_prompt_info)'
fi

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    elapsed_time=$(($SECONDS - $timer))
    if [[ $elapsed_time -le 1 ]]; then
      timer_view=""
    else
      timer_view="${elapsed_time}s"
    fi
    unset timer
  fi
}
