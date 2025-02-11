.PHONY: all

all:
		cp -rv .config/nvim $(HOME)/.config/
		cp -rv .config/foot $(HOME)/.config/
		cp -v .tmux.conf $(HOME)/
		cp -rv .config/fish $(HOME)/.config/
		cp -v .config/starship.toml $(HOME)/.config/
		cp -v .gitconfig $(HOME)/
		cp -v .gitignore $(HOME)/
