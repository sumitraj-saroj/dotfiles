#!/usr/bin/env bash
# Prints "<folder-icon> <path>" and, if inside a git repo,
# appends a git branch icon + branch name.
#
# Called from tmux.conf like:
#   #(~/.config/tmux/scripts/right-status.sh '#{pane_current_path}')

dir="$1"
short=$(echo "$dir" | sed "s|^$(getent passwd "$USER" | cut -d: -f6)|~|")

branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null \
      || git -C "$dir" describe --tags --exact-match HEAD 2>/dev/null \
      || git -C "$dir" rev-parse --short HEAD 2>/dev/null)

if [[ -n "$branch" ]]; then
  printf '\uf07c %s  \ue725 %s' "$short" "$branch"
else
  printf '\uf07c %s' "$short"
fi
