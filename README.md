# hylu-dev dotfiles

This repository manages my dotfiles using [yadm](https://yadm.io/).

## Prerequisites

Before cloning, you need to set up Git, Yadm, and an AUR helper (Paru).

### 1. Install Git, Yadm, and Base-devel

```bash
sudo pacman -S --needed git base-devel yadm
```

### 2. Install Paru (AUR Helper)

```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
```

### 3. Setup Git Credential Manager (GCM)

Install GCM using Paru to handle authentication easily:

```bash
paru -S git-credential-manager-bin
git-credential-manager configure
git config --global credential.helper manager
git config --global credential.credentialStore secretservice
```

*Note: You may need to set a credential store (e.g., secretservice or gpg) depending on your desktop environment.*

## Installation

To bootstrap this configuration on a new machine:

```bash
yadm clone <url-to-this-repo>
```

## Package Management

This setup maintains lists of installed packages in `.config/yadm/`.

### Generating Package Lists

To update the package lists based on your currently installed packages, run the following commands:

**Native Packages (pacman):**
```bash
pacman -Qqen > ~/.config/yadm/pkglist.txt
```

**Foreign Packages (AUR):**
```bash
pacman -Qqem > ~/.config/yadm/foreign_pkglist.txt
```

### Installing Packages

Once `paru` is installed, you can use it to install all packages from the lists:

**Native Packages:**
```bash
paru -S --needed - < ~/.config/yadm/pkglist.txt
```

**Foreign Packages:**
```bash
paru -S --needed - < ~/.config/yadm/foreign_pkglist.txt
```

## Btrfs Snapper Setup

To set up automatic snapshots for the root filesystem:

1. **Create Config for Root:**
   ```bash
   sudo snapper -c root create-config /
   ```

2. **Enable Timers:**
   ```bash
   sudo systemctl enable --now snapper-timeline.timer
   sudo systemctl enable --now snapper-cleanup.timer
   ```

3. **(Optional) Install GRUB-Btrfs:**
   If you want snapshots to appear in GRUB:
   ```bash
   paru -S grub-btrfs
   sudo systemctl enable --now grub-btrfs.path
   ```

## Systemd Services

Enable these services for a fully functional system:

### Power & Laptop management
```bash
sudo systemctl enable --now tlp.service       # Power saving
sudo systemctl enable --now thermald.service  # Intel thermal management
sudo systemctl mask systemd-rfkill.service    # Prevent conflicts with TLP
```

### Networking & Bluetooth
```bash
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
```

### Virtualization & Security
```bash
sudo systemctl enable --now docker.socket     # Starts docker only when needed
sudo systemctl enable --now ly.service        # Your login manager
sudo usermod -aG docker,video,audio,input $USER
```
