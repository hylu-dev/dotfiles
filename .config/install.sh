#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define a function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "🔧 Starting Linux environment setup..."

# Check if apt is available
if ! command_exists apt; then
  echo "❌ Error: 'apt' command not found. This script is for Debian/Ubuntu-based systems like Pop!_OS."
  exit 1
fi

echo "🔄 Updating package list..."
sudo apt update

# Define all packages to install in one list for efficiency and clarity
echo "📦 Installing core utilities and development tools..."
PACKAGES=(
  curl
  git
  bat
  eza
  tldr
  fastfetch
  fzf
  xclip
  neovim
  cowsay
  fortune
  cmatrix
)

# Loop through each package and install it
for package in "${PACKAGES[@]}"; do
  echo "📦 Installing '$package'..."
  sudo apt install -y -q "$package"
done

echo "✅ All packages installed successfully."

# Optional: Add a path to ~/.local/bin if it exists and is not in PATH
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo "Adding ~/.local/bin to PATH in .bashrc"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
fi

echo "🔧 Installing Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "🔧 Installing Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
rm lazygit.tar.gz

echo "🎉 Setup complete! Please open a new terminal or run 'source ~/.bashrc' to apply changes."
