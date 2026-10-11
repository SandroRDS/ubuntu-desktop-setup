BASE_PATH="$HOME/ubuntu-desktop-setup"

# Instalando pacotes essenciais
sudo apt update
sudo apt install build-essential curl wget git

# Homebrew Setup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ZSH + Oh My ZSH Setup
sudo apt install zsh
ln -sf "$BASE_PATH/.zshrc" ~/.zshrc
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install fzf
brew install --cask font-meslo-lg-nerd-font
brew install powerlevel10k
ln -sf "$BASE_PATH/.config/.p10k.zsh" ~/.p10k.zsh

# Kitty Setup
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/bin/
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 50
sudo update-alternatives --config x-terminal-emulator
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

# Docker Setup
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc | cut -f1)
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Node Setup
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
nvm install node
nvm use node
npm install -g yarn

# Chrome Setup
wget -qO- https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /tmp/chrome.deb && sudo apt update && sudo apt install -y /tmp/chrome.deb && rm /tmp/chrome.deb

# VSCode Setup
sudo snap install --classic code

# Postman Setup
sudo snap install postman

# Obsidian Setup
sudo snap install obsidian --classic