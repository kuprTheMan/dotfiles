# Turn off greeting
set -U fish_greeting

# Vi mode
set -g fish_key_bindings fish_vi_key_bindings
set -gx fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line blink

bind -M insert \cp up-or-search
bind -M insert \cn down-or-search
bind -M insert \cf accept-autosuggestion

# Aliases
alias vim "nvim"
alias ls "eza --icons -F -H"
alias ll "eza --icons -F -H --group-directories-first --git -all"
alias tree "eza --tree -L 3"

# Abbrs
abbr --add "eudn" "sudo emerge -uDN @world"
abbr --add "eisy" "sudo eix-sync"

# Shell Ingretions
fzf --fish | source
starship init fish | source
zoxide init fish --cmd cd | source
