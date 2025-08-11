#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Utility Functions ---

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# --- Main Script Logic ---

if ! command_exists dnf; then
  echo "❌ Error: 'dnf' command not found. This script is for Fedora-based systems."
  exit 1
fi

read -r -p "This script will install a list of packages and tools. Do you want to continue? (y/n): " confirm
case "$confirm" in
  [yY])
    echo "📦 Starting package installation..."

    PACKAGES=(
      curl
      bat
      eza
      tldr
      zoxide
      fastfetch
      fzf
      xclip
      ghostty
      neovim
      btrfs-assistant
      cowsay
      fortune
      cmatrix
    )

    dnf copr enable -y dejan/lazygit
    dnf copr enable -y scottames/ghostty
    dnf copr enable -y dturner/eza

    echo "📦 Installing core utilities and development tools..."
    for package in "${PACKAGES[@]}"; do
      echo "📦 Installing '$package'..."
      sudo dnf install -y "$package"
    done
    echo "✅ All packages installed successfully."

    if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
      echo "Adding ~/.local/bin to PATH in .bashrc"
      echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
    fi

    echo "🔧 Installing Oh My Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s

    echo "🎉 Package setup complete! Please open a new terminal or run 'source ~/.bashrc' to apply changes."
    ;;
  *)
    echo "Exiting without making changes."
    exit 0
    ;;
esac
