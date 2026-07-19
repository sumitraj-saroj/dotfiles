#!/usr/bin/env bash
# Maps a process/command name to a Nerd Font icon.
# Usage: pane-icon.sh <command_name>
#
# Called from tmux.conf window-status-format like:
#   #(~/.config/tmux/scripts/pane-icon.sh '#{pane_current_command}')

cmd="${1,,}"  # lowercase

case "$cmd" in
  bash|zsh|fish|sh|dash)  printf '\ue795' ;;    # 
  nvim|vim|vi)            printf '\uf040' ;;    # 
  nano|micro|helix|hx)    printf '\uf044' ;;    # 
  node|bun|deno)          printf '\ue718' ;;    # 
  python|python3|ipython) printf '\ue73c' ;;    # 
  ruby|irb)               printf '\ue739' ;;    # 
  go)                     printf '\ue627' ;;    # 
  rust|cargo|rustc)       printf '\ue7a8' ;;    # 
  java|javac|kotlin)      printf '\ue738' ;;    # 
  gcc|g++|make|cmake)     printf '\uf085' ;;    # 
  git|tig|lazygit)        printf '\ue725' ;;    # 
  docker|podman)          printf '\uf308' ;;    # 
  ssh|mosh)               printf '\uf489' ;;    # 
  htop|btop|top)          printf '\uf080' ;;    # 
  man|less|more)          printf '\uf02d' ;;    # 
  curl|wget|http)         printf '\uf0ac' ;;    # 
  mysql|psql|sqlite3)     printf '\uf1c0' ;;    # 
  npm|yarn|pnpm)          printf '\ue71e' ;;    # 
  cat|bat)                printf '\uf15c' ;;    # 
  find|fd|rg|grep|ag)     printf '\uf002' ;;    # 
  tar|zip|unzip|gzip)     printf '\uf187' ;;    # 
  sudo)                   printf '\uf132' ;;    # 
  tmux)                   printf '\uf489' ;;    # 
  *)                      printf '\uf120' ;;    # 
esac
