#!/usr/bin/env bash

set -euo pipefail

PROJ_DIR="$HOME/Projects"
WORK_PROJ_DIR="$PROJ_DIR/Work"
PERSONAL_PROJ_DIR="$PROJ_DIR/kuprTheMan"
NOTES_DIR="$PERSONAL_PROJ_DIR/Notes"
DOT_DIR=$(realpath $(dirname $0)/../)
 
info() {
    printf "\n\033[1;34m%s\033[0m\n" "$1"
}

success() {
    printf "🆗 \033[1;32m%s\033[0m\n" "$1"
}

debug() {
    printf "⚒️ \033[1;37m%s\033[0m\n" "$1"
}

error() {
    printf "🤕 \033[1;31m%s\033[0m\n" "$1"
}

warning() {
    printf "⚠️ \033[1;33m%s\033[0m\n" "$1"
}

symln() {
    local target="$1"
    local link="$2"

    if [ ! -e "$link" ]; then
        ln -sv "$target" "$link"
        success "Added symlink $link to $target"
    elif [ -L "$link" ] && [ "$(readlink "$link")" = "$target" ]; then
        debug "Symlink already exists: $link"
    else
        warning "$link exists but is not a symlink to $target"
    fi
}

clone_repo() {
    local repo="$1"
    local dest="$2"

    if [ ! -d "$dest" ]; then
        git clone "$repo" "$dest" \
            && success "Repository cloned $repo to $dest" \
            || error "Repository $repo cannot be cloned to $dest"
    else
        debug "Repository already exists: $dest"
    fi
}
