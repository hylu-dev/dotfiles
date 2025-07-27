#!/bin/bash

set -e

echo "🔧 Installing Linux utilities..."

sudo apt update
sudo apt install -y \
  curl \
  git \
  bat \
  eza \
  tldr \
  fastfetch \
  neovim \
  fzf \
  stow

echo "✅ Packages installed."
