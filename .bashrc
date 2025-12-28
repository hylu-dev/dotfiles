#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR="nvim"
export VISUAL="nvim"

# Set history control to ignore duplicates and lines starting with a space
HISTCONTROL=ignoreboth

# Append history, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Update window dimensions after each command
shopt -s checkwinsize

# Enable recursive globbing with **
shopt -s globstar

# Configure less for non-text files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add ~/.local/bin to PATH
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Load Cargo binaries
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Run fastfetch on terminal start
fastfetch

# Load personal aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

eval "$(starship init bash)"

# Zoxide startup
eval "$(zoxide init bash)"

# Flutter Development
export PATH="$PATH:$HOME/flutter/bin"
export CHROME_EXECUTABLE="/usr/bin/chromium"

# Nix direnv
eval "$(direnv hook bash)"
