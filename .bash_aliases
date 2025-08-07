# ls to eza alias
alias ls='eza -a --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons'
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'

alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias to check for pop updates
alias pop='pop-upgrade release update'

# alias for bat
alias bat='batcat'

# clipboard
alias clip='xclip -selection clipboard <'

# df use gigabytes
alias df='df -BG'

# zoxide alias
cd() {
  if [ -z "$1" ]; then # If no argument is provided
    cd ~                # Go to the home directory
  else
    z "$@"              # Otherwise, use zoxide's 'z' command
  fi
}
