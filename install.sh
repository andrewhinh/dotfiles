#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

for f in \
  .zshrc .profile .zshenv .zprofile .bash_profile .bashrc .brewenv \
  .gitconfig .gitignore_global .vimrc .node-version
do
  [[ -f "$DOTFILES/$f" ]] || { echo "missing $f" >&2; exit 1; }
  ln -sf "$DOTFILES/$f" "$HOME/$f"
done

echo "Linked dotfiles from $DOTFILES"
