# Instalando pacotes do APT
sudo apt update
xargs -a apt-packages.txt sudo apt install -y

# ZSH + Oh My ZSH Setup
ln -sf ~/ubuntu-desktop-setup/.zshrc ~/.zshrc
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Definindo wallpaper
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/ubuntu-desktop-setup/assets/wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/ubuntu-desktop-setup/assets/wallpaper.png"