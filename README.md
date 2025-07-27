### My Dotfiles

This repository contains my personal configuration files (dotfiles) for a Pop!\_OS setup, managed using a bare Git repository.

### Requirements

* Git installed on your system.

### Installation

Follow these steps to set up the dotfiles on a new machine:

1.  **Clone the repository as a bare repository:**
    ```bash
    git clone --bare https://github.com/hylu-dev/dotfiles.git $HOME/.dotfiles
    ```

2.  **Create a shell alias for managing the dotfiles:**
    Add the following line to your `~/.bashrc` or `~/.zshrc` file:
    ```bash
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```
    Then, apply the changes: `source ~/.bashrc`

3.  **Checkout the dotfiles to your home directory:**
    ```bash
    dotfiles checkout
    ```
    * If you get an error about files already existing, back them up first:
        ```bash
        mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
        dotfiles checkout
        ```

4.  **Prevent untracked files from showing up:**
    ```bash
    dotfiles config --local status.showUntrackedFiles no
    ```

### Usage

Use the `dotfiles` alias just like a normal `git` command to manage your files:

```bash
# Add a new file to the repo
dotfiles add .newconfig

# Commit your changes
dotfiles commit -m "Added new config file"

# Push to your remote repository
dotfiles push
