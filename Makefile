CWD=$(shell pwd)

all: terminal git neovim zsh i3 rofi

terminal:
	sudo pacman -S --noconfirm --needed alacritty
	rm -rf $(HOME)/.config/alacritty
	ln -sfn $(CWD)/.config/alacritty $(HOME)/.config/alacritty

neovim:
	sudo pacman -S --noconfirm --needed python-neovim neovim
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
	sudo pacman -S --noconfirm --needed xclip

i3:
	sudo pacman -S --noconfirm --needed xorg-server xorg-xinit i3-gaps i3lock
	# Picom is compositor (compton fork)
	# Maim is screenshoot's utility
	# dunst is notification daemon
	# hsetroot is a wallpaper handler
	# xsettingsd used to provide fonts configuration to GTK apps
	sudo pacman -S --noconfirm --needed picom xdotool maim dunst network-manager-applet hsetroot xsettingsd
	yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --needed polybar
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
	rm -rf $(HOME)/.wallpaper.png
	ln -sfn $(CWD)/.wallpaper.png $(HOME)/.wallpaper.png
	rm -rf $(HOME)/.config/dunst
	ln -sfn $(CWD)/.config/dunst $(HOME)/.config/dunst
	rm -rf $(HOME)/.xsettingsd
	ln -sfn $(CWD)/.xsettingsd $(HOME)/.xsettingsd
	@echo "Add \"exec i3\" to \"/etc/X11/xinit/xinitrc\""

rofi:
	sudo pacman -S --noconfirm --needed rofi
	rm -rf $(HOME)/.config/rofi
	ln -sfn $(CWD)/.config/rofi $(HOME)/.config/rofi
	rm -rf $(HOME)/.local/share/fonts/rofi
	ln -sfn $(CWD)/.config/rofi/fonts $(HOME)/.local/share/fonts/rofi
	yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --needed papirus-icon-theme
	fc-cache

.PHONY: terminal git neovim zsh i3 rofi
