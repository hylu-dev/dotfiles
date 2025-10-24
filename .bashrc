# Exit for non-interactive sessions
if [[ -z "$PS1" ]]; then
  return
fi

# ~/.bashrc: Executed for interactive non-login shells.

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

# --- Distribution-Specific Settings ---
# Handle Debian/Ubuntu-specific chroot prompt
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Add an "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Load personal aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Load bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- Custom Additions ---

# Add ~/.local/bin to PATH
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Load Cargo binaries
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Oh My Posh
if command -v oh-my-posh &>/dev/null; then
  eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/theme.omp.json)"
fi

# Neovim path
export PATH="$PATH:/opt/nvim/"

# Zoxide startup
eval "$(zoxide init bash)"

# Run fastfetch on terminal start
fastfetch

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

