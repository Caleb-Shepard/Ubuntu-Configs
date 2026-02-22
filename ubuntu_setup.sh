#!/usr/bin/env bash
set -euo pipefail

cd ~

echo "== System update =="
sudo apt update
sudo apt full-upgrade -y

echo "== Base packages =="
sudo apt install -y \
  git python3 python3-pip default-jdk curl gradle \
  xclip dc3dd zsh nmap lolcat cowsay fortune vim \
  yt-dlp gparted python3-build build-essential \
  kubuntu-desktop wget tmux \
  p7zip-full python3-wxgtk4.0 grub2-common grub-pc-bin \
  flatpak

echo "== Remove snap (if present) =="
sudo systemctl disable snapd.service || true
sudo apt purge -y snapd || true
rm -rf ~/snap

echo "== Install Flatpak + Flathub =="
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "== Install Flatpak Apps =="
flatpak install -y flathub \
  org.mozilla.firefox \
  org.signal.Signal \
  com.bitwarden.desktop \
  org.telegram.desktop \
  com.slack.Slack \
  io.github.shiftey.Desktop \
  com.discordapp.Discord \
  com.spotify.Client \
  com.visualstudio.code \
  org.gimp.GIMP \
  org.prismlauncher.PrismLauncher

echo "== Install Node LTS (current) =="
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "== Clone config repo =="
git clone https://github.com/Caleb-Shepard/Ubuntu-Configs.git
mv Ubuntu-Configs/opconfig* ~/

echo "== Install Oh My Zsh =="
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s "$(which zsh)"

echo "== Add aliases to shells =="
echo "source ~/.aliases.sh" >> ~/.zshrc
echo "source ~/.aliases.sh" >> ~/.bashrc

echo "== Xmodmap setup =="
echo "xmodmap ~/.Xmodmap" >> ~/.xinitrc

echo "== Install WoeUSB-ng =="
git clone https://github.com/WoeUSB/WoeUSB-ng.git
cd WoeUSB-ng
sudo pip3 install .
cd ..
rm -rf WoeUSB-ng

echo "== Install keyd =="
git clone https://github.com/rvaiya/keyd.git
cd keyd
make
sudo make install
sudo systemctl enable keyd
sudo systemctl start keyd

sudo tee /etc/keyd/default.conf > /dev/null <<EOF
[ids]
*

[main]
capslock=leftcontrol
leftcontrol=leftalt
leftalt=esc
backslash=underscore
rightalt=backslash
EOF

cd ..
rm -rf keyd

echo "== Install Firefox Extensions (opens browser tabs) =="
addon_pages=(
  "https://addons.mozilla.org/firefox/addon/bitwarden-password-manager/"
  "https://addons.mozilla.org/firefox/addon/ublock-origin/"
  "https://addons.mozilla.org/firefox/addon/darkreader/"
  "https://addons.mozilla.org/firefox/addon/enhancer-for-youtube/"
  "https://addons.mozilla.org/firefox/addon/epubreader/"
  "https://addons.mozilla.org/firefox/addon/facebook-container/"
  "https://addons.mozilla.org/firefox/addon/multi-account-containers/"
  "https://addons.mozilla.org/firefox/addon/open-url-in-container/"
  "https://addons.mozilla.org/firefox/addon/tranquility-1/"
  "https://addons.mozilla.org/firefox/addon/youtube-audio/"
  "https://addons.mozilla.org/firefox/addon/user-agent-string-switcher/"
)

for url in "${addon_pages[@]}"; do
  flatpak run org.mozilla.firefox "$url" &
done

echo "== Cleanup =="
sudo apt autoremove -y

echo "== Run optional scripts =="
chmod +x options/*
options/natural_scrolling.sh || true
options/pinyin_support.sh || true
options/wallpapers.sh || true

echo "== Done! Reboot recommended =="
