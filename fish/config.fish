set -g fish_greeting
if status is-interactive
    fastfetch
end

starship init fish | source
