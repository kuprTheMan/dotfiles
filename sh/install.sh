#! /usr/bin/env bash

source $(dirname $0)/utils.sh

setup_basic_directories() {
    info "📁 Creating basic directories..."
    mkdir -pv "$PERSONAL_PROJ_DIR" "$WORK_PROJ_DIR"
}

setup_notes() {
    info "📝 Setting up notes..."

    clone_repo "git@github.com:kuprTheMan/notes.git" $NOTES_DIR
}

setup_config_files() {
    info "⚙️ Setting up config links..."
    local config_dir="$HOME/.config"
    mkdir -pv "$config_dir"

    # Lists of configs
    local items=(
      nvim
      foot
      niri
      waybar
      fuzzel
      mako
      fish
      tmux
      git
      gtk-3.0
    )

    for item in "${items[@]}"; do
        symln "$DOT_DIR/.config/$item" "$config_dir/$item"
    done
}

setup_bash() {
  info "🐚 Configuring .bashrc..."

  {
    echo "# Dotfile dir"
    echo "export DOT=\"$DOT_DIR\""
    echo "[ -f \"\$DOT/.bashrc\" ] && source \"\$DOT/.bashrc\""
  } > "$HOME/.bashrc"
}


setup_tmux_plugin_manger() {
    info "🖥️ Setting up TPM..."

    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$tpm_dir" ]; then
        clone_repo "https://github.com/tmux-plugins/tpm" "$tpm_dir"
        "$tpm_dir/bin/install_plugins"
        success "TPM installed"
    else
        debug "TPM already installed"
    fi
}

setup_pass() {
    info "🔐 clone password-store..."

    clone_repo "git@github.com:kuprTheMan/passwords.git" "$HOME/.password-store/"
}

main() {
    setup_basic_directories
    setup_notes
    setup_config_files
    setup_bash
    setup_tmux_plugin_manger
    setup_pass

    success "🎉 Setup completed successfully!"
}

main "$@"
