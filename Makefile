CWD=$(shell pwd)

all: terminal git neovim zsh i3 rofi

terminal:
	sudo pacman -S --needed alacritty
	rm -rf $(HOME)/.config/alacritty
	ln -sfn $(CWD)/.config/alacritty $(HOME)/.config/alacritty

neovim:
	sudo pacman -S --needed python-neovim neovim
	rm -rf $(HOME)/.config/nvim
	ln -sfn $(CWD)/.config/nvim $(HOME)/.config/nvim
	curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git:
	rm -rf $(HOME)/.gitconfig
	ln -sf $(CWD)/.gitconfig $(HOME)/.gitconfig
	ln -sf $(CWD)/.gitignore_global $(HOME)/.gitignore_global

zsh:
	rm -rf $(HOME)/.zsh_profile
	rm -rf $(HOME)/.zsh_aliases
	ln -sf $(CWD)/.zsh_aliases $(HOME)/.zsh_aliases
	ln -sf $(CWD)/.zsh_profile $(HOME)/.zsh_profile
	echo "source ~/.zsh_aliases" >> $(HOME)/.zshrc
	echo "source ~/.zsh_profile" >> $(HOME)/.zshrc
	sed -i 's/robbyrussell/agnoster/g' $(HOME)/.zshrc
	sed -i 's/plugins=(.*)/plugins=(git gpg-agent ssh-agent docker kubectl sudo)/g' $(HOME)/.zshrc
	# xclip used to copy output to clipboard. e.g. cat file | xclip -sel clip
	sudo pacman -S --needed xclip

i3:
	sudo pacman -S --needed xorg-server xorg-xinit i3-gaps
	# Picom is compositor (compton fork)
	# Maim is screenshoot's utility
	# dunst is notification daemon
	sudo pacman -S --needed picom xdotool maim dunst network-manager-applet
	yay -S polybar
	rm -rf $(HOME)/.config/i3
	ln -sfn $(CWD)/.config/i3 $(HOME)/.config/i3
	rm -rf $(HOME)/.config/polybar
	ln -sfn $(CWD)/.config/polybar $(HOME)/.config/polybar
	rm -rf $(HOME)/.local/share/fonts/polybar
	ln -sfn $(CWD)/.config/polybar/fonts $(HOME)/.local/share/fonts/polybar
	fc-cache
	rm -rf $(HOME)/.scripts
	ln -sfn $(CWD)/scripts $(HOME)/.scripts
	mkdir -p $(HOME)/Pictures/screenshots
	@echo "Add \"exec i3\" to \"/etc/X11/xinit/xinitrc\""

rofi:
	sudo pacman -S --needed rofi
	rm -rf $(HOME)/.config/rofi
	ln -sfn $(CWD)/.config/rofi $(HOME)/.config/rofi
	rm -rf $(HOME)/.local/share/fonts/rofi
	ln -sfn $(CWD)/.config/rofi/fonts $(HOME)/.local/share/fonts/rofi
	yay -S papirus-icon-theme
	fc-cache

.PHONY: terminal git neovim zsh i3 rofi
