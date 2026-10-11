BASE_PATH="$HOME/ubuntu-desktop-setup"

# Instalando pacotes do APT
sudo apt update
xargs -a apt-packages.txt sudo apt install -y

# Homebrew Setup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ZSH + Oh My ZSH Setup
ln -sf "$BASE_PATH/.zshrc" ~/.zshrc
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install fzf
brew install --cask font-meslo-lg-nerd-font
brew install powerlevel10k
ln -sf "$BASE_PATH/.config/.p10k.zsh" ~/.p10k.zsh

# Kitty Setup
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list
ln -sf "$BASE_PATH/.config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
ln -sf "$BASE_PATH/.config/kitty/current-theme.conf" ~/.config/kitty/current-theme.conf

# Definindo wallpaper
WALLPAPER_PATH="file://$BASE_PATH/assets/wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri "$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "$WALLPAPER_PATH"
gsettings set org.gnome.desktop.screensaver picture-uri "$WALLPAPER_PATH"