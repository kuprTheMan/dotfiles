.PHONY: tools terminal shell de
all: tools terminal shell de

tools:
		cp -rv .config/nvim $(HOME)/.config
		cp -v .gitignore $(HOME)/
		cp -v .gitconfig $(HOME)/

terminal:
		cp -rv .config/foot $(HOME)/.config
		cp -rv .tmux.conf $(HOME)/

shell:
		cp -v .config/fish $(HOME)/.config
		cp -v .config/starship.toml $(HOME).config

de:
	cp -rv .config/sway $(HOME)/.config
	cp -rv .config/swaylock $(HOME)/.config
	cp -rv .config/swaync $(HOME)/.config
	cp -rv .config/waybar $(HOME)/.config
	cp -rv .config/fuzzel $(HOME)/.config
	cp -rv .config/gtk-3.0 $(HOME)/.config
