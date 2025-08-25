#!/usr/bin/env bash

#  TODO: OS installator: WIP

source $(dirname $0)/utils.sh

install_basic_packages() {
    local packages=(
        # Base
        app-admin/eclean-kernel
        app-eselect/eselect-repository
        app-portage/eix
        app-portage/genlop
        app-portage/gentoolkit
        app-text/ansifilter
        app-text/wgetpaste
        sys-apps/usbutils
        sys-auth/rtkit
        x11-libs/libnotify
        gui-apps/qt6ct
        # Dev
        app-containers/docker
        app-containers/docker-buildx
        app-containers/docker-cli
        app-misc/diff-so-fancy
        app-misc/tmux
        app-editors/neovim
        app-shells/fish
        dev-db/postgresql
        dev-lang/go
        dev-util/pkgdev
        # Util
        app-misc/cliphist
        app-misc/jq
        sys-fs/ncdu
        sys-process/htop
        app-shells/fzf
        app-shells/starship
        app-shells/zoxide
        sys-apps/eza
        sys-apps/pkgcore
        sys-apps/ripgrep
        sys-apps/smartmontools
        # DE
        app-office/obsidian
        gui-apps/foot
        gui-apps/fuzzel
        gui-apps/grim
        gui-apps/mako
        gui-apps/slurp
        gui-apps/swaybg
        gui-apps/swayidle
        gui-apps/tuigreet
        gui-apps/waybar
        gui-apps/wf-recorder
        gui-apps/wl-clipboard
        gui-apps/wlr-randr
        gui-libs/greetd
        sys-apps/xdg-desktop-portal
        gui-libs/xdg-desktop-portal-wlr
        sys-apps/xdg-desktop-portal-gtk
        gui-wm/sway
        media-fonts/nerdfonts
        media-fonts/noto
        media-fonts/noto-cjk
        media-fonts/noto-emoji
        media-gfx/imv
        media-video/pipewire
        x11-misc/autotiling
        x11-themes/apple-cursor
        xfce-base/thunar
    )

    if [[ ${#packages[@]} -eq 0 ]]; then
        error "No packages specified"
        return 1
    fi

    if [[ $EUID -ne 0 ]]; then
        error "Script must be run as root"
        return 1
    fi

    local total=${#packages[@]}
    local installed=0
    local skipped=0
    local failed=0

    for package in "${packages[@]}"; do
        if equery list "$package" &>/dev/null; then
            warning "Package $package already installed - skipping"
            ((skipped++))
            continue
        fi

        info "Installing package $package..."

        if timeout 3600 emerge --ask=n --quiet-build=n --autounmask-write --autounmask-continue "$package" 2>&1; then
            success "Package $package installed successfully"
            ((installed++))
        else
            local exit_code=$?
            if [[ $exit_code -eq 124 ]]; then
                error "Package $package installation timed out after 1 hour"
            else
                error "Failed to install package $package"
            fi

            local log_dir="/var/log/portage"
            local latest_log=$(find "$log_dir" -name "*${package}*" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)

            if [[ -n "$latest_log" ]]; then
                echo "Build log: $latest_log"
                tail -20 "$latest_log"
            fi

            if [[ -f "/var/log/emerge.log" ]]; then
                echo "Recent emerge.log entries:"
                tail -10 /var/log/emerge.log | grep -E "(FAILED|ERROR|$package)"
            fi

            ((failed++))
        fi

        sleep 1
    done

    echo "Summary: $total total, $installed installed, $skipped skipped, $failed failed"

    if [[ $failed -gt 0 ]]; then
        return 1
    fi

    return 0
}

main() {
    install_basic_packages
}

main "$@"
