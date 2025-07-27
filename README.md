# hylu-dev dotfiles

This repository contains my personal configuration files (dotfiles), managed using a bare Git repository.

## Requirements

* Git installed on your system.

## Installation

Follow these steps to set up the dotfiles on a new machine:

1.  **Clone the repository as a bare repository:**
    ```bash
    git clone --bare https://github.com/hylu-dev/dotfiles.git $HOME/.dotfiles
    ```

2.  **Temporarily create a shell alias for managing the dotfiles:**
    ```bash
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```
    - This will later be stowed into `~/.bashrc`

3.  **Checkout the dotfiles to your home directory:**
    ```bash
    # Try to checkout dotfiles, backing up existing files if necessary
    if ! dotfiles checkout; then
      echo "Backing up pre-existing dotfiles..."
      mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
      dotfiles checkout
    fi

4.  **Prevent untracked files from showing up:**
    ```bash
    dotfiles config --local status.showUntrackedFiles no
    ```
### Quick Run

```bash
git clone --bare https://github.com/hylu-dev/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
if ! dotfiles checkout; then
  echo "Backing up pre-existing dotfiles..."
  mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
  dotfiles checkout
fi
dotfiles config --local status.showUntrackedFiles no
```

## Usage

Use the `dotfiles` alias just like a normal `git` command to manage your files:

```bash
# Add a new file to the repo
dotfiles add .newconfig

# Commit your changes
dotfiles commit -m "Added new config file"

# Push to your remote repository
dotfiles push
