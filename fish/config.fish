set -g fish_greeting
if status is-interactive
    fastfetch
    # Abbreviations
    abbr -a ls eza --icons --group-directories-first
    abbr -a cd z
    abbr -a cat bat
    abbr -a fn 'fzf --preview "bat --style=numbers --color=always --line-range :500 {}" --bind "enter:execute(nvim {})+abort"'
    abbr -a kp 'ps -ef | fzf | awk "{print \$2}" | xargs kill -9'
    zoxide init fish | source
    abbr -a h 'history | fzf --reverse --height 40% | read -l cmd; eval $cmd'
    if not set -q GNOME_KEYRING_CONTROL
        eval (gnome-keyring-daemon --start 2>/dev/null | string replace -r '([^=]+)=(.*)' 'set -gx $1 "$2";')
    end
    function fr
        rg --line-number --no-heading --color=always --smart-case $argv | fzf --ansi --delimiter : \
            --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
            --bind 'enter:execute(nvim +{2} {1})'
    end

end

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
