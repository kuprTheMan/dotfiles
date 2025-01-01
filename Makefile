.PHONY: tools terminal shell de
all: tools terminal shell de

tools:
		cp -rv .config/nvim $(HOME)/.config
		cp -v .config/git/.gitignore $(HOME)/
		cp -v .config/git/.gitconfig $(HOME)/

terminal:
		cp -rv .config/foot $(HOME)/.config
		cp -rv .config/tmux $(HOME)/.config

shell:
		cp -v .config/zsh/.zshenv $(HOME)/
		cp -v .config/zsh/.zshrc $(HOME)/
		cp -v .config/zsh/starship.toml $(HOME).config

de:
	cp -rv .config/sway $(HOME)/.config
	cp -rv .config/swaylock $(HOME)/.config
	cp -rv .config/swaync $(HOME)/.config
	cp -rv .config/waybar $(HOME)/.config
	cp -rv .config/rofi $(HOME)/.config
	cp -rv .config/gtk-3.0 $(HOME)/.config
