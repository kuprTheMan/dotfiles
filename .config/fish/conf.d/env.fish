# Nvim
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

#Go
set -gx GOPATH $HOME/.go
set -gx GOBIN $HOME/.go/bin

# Fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

set -gx FZF_COLORS "bg+:-1,\
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

set -gx FZF_DEFAULT_OPTS "--height 60% \
--border sharp \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer  \
--marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"
