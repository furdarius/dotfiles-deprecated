Templates took from https://github.com/adi1090x/rofi (Rofi Based Custom Applets And Menus)

ArchLinux original installation:
```
sudo pacman -S rofi
mkdir -p $(HOME)/.config/rofi
git clone https://github.com/adi1090x/rofi.git $(HOME)/.config/rofi/repo
chmod +x $(HOME)/.config/rofi/repo/scripts/*
cp -r $(HOME)/.config/rofi/repo/{bin,scripts,themes,launchers,config.rasi} $(HOME)/.config/rofi
rm -rf $(HOME)/.local/share/fonts/rofi
mkdir -p $(HOME)/.local/share/fonts/rofi
cp -r $(HOME)/.config/rofi/repo/fonts/* $(HOME)/.local/share/fonts/rofi
fc-cache
rm -rf $(HOME)/.config/rofi/repo
```
