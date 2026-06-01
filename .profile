cd_up() {
  if [ -z "$1" ]; then
    echo "Usage: cd.. N (where N is the number of directories to move up)"
  else
    cd $(printf "%0.s../" $(seq 1 $1)) || return
  fi
}
alias cd..='cd_up'

flatten() {
  file_count=$(find . -mindepth 2 -type f | wc -l | tr -d ' ')

  if [ "$file_count" -eq 0 ]; then
    echo "No files found in subdirectories to flatten."
    return
  fi

  echo "This will move $file_count file(s) from subdirectories into the current directory."
  echo "Empty directories will be removed."
  printf "Are you sure you want to proceed? (y/N): "
  read confirm

  if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Operation cancelled."
    return
  fi

  find . -mindepth 2 -type f -exec sh -c '
    for f; do
      base=$(basename "$f")
      if [ -e "./$base" ]; then
        echo "skip (exists): $base"
      else
        mv "$f" .
      fi
    done
  ' _ {} +
  find . -type d -empty -delete

  echo "Flattening complete."
}

export EDITOR=vim
export VISUAL="$EDITOR"
export FZF_DEFAULT_COMMAND='fd'

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.ghcup/env" ]] && . "$HOME/.ghcup/env"
[[ -S "$HOME/.colima/docker.sock" ]] && export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"

[[ -f "$HOME/.profile.local" ]] && . "$HOME/.profile.local"
