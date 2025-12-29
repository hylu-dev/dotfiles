if status is-interactive
    # Environment Variables
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx CHROME_EXECUTABLE /usr/bin/chromium

    # Path Additions
    if test -d "$HOME/.local/bin"
        fish_add_path "$HOME/.local/bin"
    end

    # Cargo/Rust
    if test -d "$HOME/.cargo/bin"
        fish_add_path "$HOME/.cargo/bin"
    end

    # Flutter
    if test -d "$HOME/flutter/bin"
        fish_add_path "$HOME/flutter/bin"
    end

    # Aliases - eza
    alias ls='eza -a --color=always --group-directories-first --icons'
    alias ll='eza -la --icons --octal-permissions --group-directories-first'
    alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
    alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons'
    alias la='eza --long --all --group --group-directories-first'
    alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
    alias lS='eza -1 --color=always --group-directories-first --icons'
    alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
    alias l.="eza -a | grep -E '^\.'"

    # Other Aliases
    alias df='df -BG'
    alias sd='cd ~; and cd (find * -type d | fzf)'

    # Tool Initializations
    if type -q starship
        starship init fish | source
    end

    if type -q zoxide
        # Replaces 'cd' with 'z' functionality
        zoxide init fish --cmd cd | source
    end

    if type -q direnv
        direnv hook fish | source
    end

    # Run fastfetch on startup
    if type -q fastfetch
        fastfetch
    end
end