#!/bin/bash
set -e

echo "🚀 Optimizing Fedora for NVIDIA & WSL..."

# 1. DNF Performance Tweak
if ! grep -q "max_parallel_downloads" /etc/dnf/dnf.conf; then
    sudo bash -c 'cat >> /etc/dnf/dnf.conf <<EOF
max_parallel_downloads=10
fastestmirror=True
EOF'
fi

# 2. Update & Install Plugin Tools
sudo dnf upgrade --refresh -y
sudo dnf install -y 'dnf-command(copr)' git wget curl util-linux-user wslu

# 3. Enable COPRs for modern CLI tools
sudo dnf copr enable -y atim/lazygit
sudo dnf copr enable -y varlad/eza

# 4. Install Core Packages
PACKAGES=(
    bat
    eza
    tldr
    zoxide
    fastfetch
    fzf
    neovim
    lazygit
)

echo "📦 Installing core packages..."
sudo dnf install -y "${PACKAGES[@]}"

# 5. NVIDIA Container Toolkit (GPU access for containers)
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
    sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo dnf install -y nvidia-container-toolkit

# 6. RPM Fusion
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# 7. Shell Config (Dark mode & Init)
echo "🌙 Configuring environment..."
{
    echo "export GTK_THEME=Adwaita:dark"
    echo 'eval "$(zoxide init bash)"'
    echo "alias ls='eza --icons'"
    echo "alias cat='bat'"
} >> ~/.bashrc

echo "✅ Setup complete! Run 'nvidia-smi' to check your GPU."
