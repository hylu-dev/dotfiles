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

read -r -p "This script will perform system-level updates and configuration changes. Do you want to continue? (y/n): " confirm
case "$confirm" in
  [yY])
    echo "🔧 Starting Fedora basic system setup..."

    echo "🔄 Updating system and packages..."
    sudo dnf upgrade --refresh -y

    echo "⚙️ Fixing lid power issue (black screen on wake)..."
    GRUB_CONFIG="/etc/default/grub"
    if ! grep -q "ibt=off" "$GRUB_CONFIG"; then
      echo "Adding 'ibt=off' to GRUB_CMDLINE_LINUX_DEFAULT."
      sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 ibt=off"/' "$GRUB_CONFIG"
      sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    else
      echo "'ibt=off' parameter already set in GRUB."
    fi

    echo "⚙️ Configuring system to suspend to RAM..."
    LOGIND_CONF_D="/etc/systemd/logind.conf.d/custom.conf"
    if [ ! -f "$LOGIND_CONF_D" ]; then
      echo "Setting 'HandleLidSwitch' to suspend."
      echo -e "[Login]\nHandleLidSwitch=suspend\nHandleLidSwitchDocked=suspend" | sudo tee "$LOGIND_CONF_D" > /dev/null
      sudo systemctl restart systemd-logind
    else
      echo "Systemd suspend settings already configured."
    fi

    echo "📦 Enabling RPM Fusion repositories..."
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    echo "🎶 Installing multimedia codecs..."
    sudo dnf group install -y multimedia

    echo "🌐 Adding Flathub repository..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    echo "📦 Installing COPR command-line tool..."
    sudo dnf install -y 'dnf-command(copr)'

    echo "✅ Basic system setup complete! Please **reboot your computer** to apply all changes."
    ;;
  *)
    echo "Exiting without making changes."
    exit 0
    ;;
esac