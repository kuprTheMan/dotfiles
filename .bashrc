# GPG
export GPG_TTY=$(tty)

# DE
export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-1
export QT_QPA_PLATFORMTHEME=qt6ct
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

# Golang
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin
export PATH=$PATH:$GOBIN

# Editor
export EDITOR="/usr/bin/nvim"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"

# Fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_COLORS="bg+:-1,\
fg:gray,\
fg+:yellow,\
border:black,\
spinner:0,\
hl:magenta,\
header:blue,\
info:green,\
pointer:red,\
marker:blue,\
prompt:gray,\
hl+:red"

export FZF_DEFAULT_OPTS="--height 60% \
--border sharp \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer  \
--marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"

# Fish as user shell
[ -x /usr/bin/fish ] && SHELL=/usr/bin/fish exec fish
