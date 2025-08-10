# hylu-dev dotfiles

This repository contains my personal configuration files (dotfiles), managed using a bare Git repository.

## Requirements

- Git installed on your system.
- Recommend installing GCM.
    - May need a reboot after installing.
    - `git config --global credential.credentialStore manager` 
    - `git config --global credential.credentialStore secretservice` 

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
    - This will later be stored in `~/.bashrc`

3.  **Checkout the dotfiles to your home directory:**
    ```bash
    # [Optionally backup existing dotfiles]
    mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/
    ```
    
    ```bash
    dotfiles checkout
    ```

5.  **Prevent untracked files from showing up:**
    ```bash
    dotfiles config --local status.showUntrackedFiles no
    ```
### Quick Run

```bash
git clone --bare https://github.com/hylu-dev/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
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
