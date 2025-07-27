#!/bin/bash

set -e

echo "🔗 Linking dotfiles..."
DOTFILES_DIR="$HOME/.dotfiles"

# Make sure you are in the dotfiles directory
cd "$DOTFILES_DIR"

stow --target="$HOME" bash
stow --target="$HOME" git
stow --target="$HOME" fastfetch

# Add the Git bare repository alias to .bashrc for future sessions
echo "Adding dotfiles alias to ~/.bashrc..."
ALIAS_LINE="alias dotfiles='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'"

# Append the alias only if it doesn't already exist
grep -qxF -- "$ALIAS_LINE" "$HOME/.bashrc" || echo "$ALIAS_LINE" >>"$HOME/.bashrc"

echo "✅ Dotfiles linked and alias added."
