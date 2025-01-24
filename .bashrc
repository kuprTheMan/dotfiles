export GPG_TTY=$(tty)

[ -x /usr/bin/fish ] && SHELL=/usr/bin/fish exec fish
