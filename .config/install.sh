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
  fzf

# Fun utilities
sudo apt install -y \
  cowsay \
  fortune \
  cmatrix

echo "✅ Packages installed."
