# Turn off greeting
set -U fish_greeting

# Vi mode
set -g fish_key_bindings fish_vi_key_bindings
set -gx fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line blink

# Binds
bind -M insert \cp up-or-search
bind -M insert \cn down-or-search
bind -M insert \cf accept-autosuggestion

# Aliases
alias nvimconf "nvim ~/.config/nvim/init.lua"
alias ls "eza -w 120 -F -H"
alias ll "eza --icons -F -H --group-directories-first --git -all"

# Abbrs
abbr --add "eudn" "sudo eix-sync && sudo emerge -uDU @world && sudo emerge -ca"

# Shell Ingretions
fzf --fish | source
starship init fish | source
zoxide init fish --cmd cd | source
