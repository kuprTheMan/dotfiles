# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select() {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;      # block
    viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select

# Start in insert mode
zle-line-init() {
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'

# History search
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# Revers select complition menu
bindkey "^[[Z" reverse-menu-complete

# History
HISTSIZE=5000
HISTFILE=~/.cache/zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt SHARE_HISTORY

# Completion styling
zstyle ':completion:*' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors 'no=00;37' 'fi=00;37' 'di=01;34' 'ln=01;36' 'pi=01;33' 'so=01;35' 'bd=01;33' 'cd=01;33' 'or=01;31' 'mi=01;31' 'ex=01;32'
zstyle ':completion:*:descriptions' format '%F{yellow}---- %d%f' 
zstyle ':completion:*:messages' format ' %F{cyan}%d%f '
zstyle ':completion:*:warnings' format ' %F{red}%d%f '
zstyle ':completion:*' list-rows-first true
zstyle ':completion:*' list-separator ' --> '
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Aliases
alias du=dust
alias vim=nvim
alias l="eza --icons -F -H --group-directories-first --git"
alias ll="eza --icons -F -H --group-directories-first --git -all"
alias lt="eza --tree -L 3"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

function ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"

# Add starship promt
eval "$(starship init zsh)"
