#!/usr/bin/bash

cd ~
# Add npm keys to apt
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# Install signal desktop
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop

# Update package managers
sudo apt update -y
sudo apt dist-upgrade -y

# ! Install packages 
apt_packages=(
    "git"
    "python3"
    "python3-pip"
    "default-jdk"
    "curl"
    "gradle"
    "xclip"
    "dc3dd"
    "zsh"
    "nmap"
    "lolcat"
    "cowsay"
    "fortune"
    "vim"
    "yt-dlp"
    "gparted"
    "pythonpy"
    "xkeycaps"
    "tmux"
    "gimp"
    "build-essential"
    "nodejs"
    "signal-desktop"
    "kubuntu-desktop"
    "wget"
)
for package in "${apt_packages[@]}"
do
   : 
   sudo apt install -y "$package"
done

# Get the rest of the repo
git clone https://github.com/Caleb-Shepard/Ubuntu-Configs .

# ! install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install modern snap packages
snap_packages=(
    "bitwarden"
    "telegram-desktop"
    "slack"
    "gh"
    "discord"
    "spotify"
)
for package in "${snap_packages[@]}"
do
    :
    sudo snap install "$package"
done

# Install snaps with classic confinement
classic_snap_packages=(
    "code"
for package in "${classic_snap_packages[@]}"
do
    :
    sudo snap install --classic "$package"
done

# add the snap paths to your profile
cat \"emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'\" >> ~/.zshrc
cat \"source '~/.aliases.sh'\" >> ~/.zshrc
cat \"emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'\" >> ~/.bashrc
cat \"source '~/.aliases.sh'\" >> ~/.bashrc

# ! Move configuration options, directories and subdirectories into filetree
mv Ubuntu-Configs/opconfig* ~/

# ! add xmodmap sourcing to your login profile
touch ~/.xinitrc
echo "xmodmap ~/.Xmodmap" >> ~/.xinitrc

# install multimc
sudo apt --fix-broken install; sudo apt install -y libqt5widgets* libqt5gui* libqt5network* libqt5core* libqt5xml* libqt5concurrent*; sudo apt --fix-broken install
curl https://files.multimc.org/downloads/multimc_1.6-1.deb -o multimc.deb && sudo dpkg -i multimc.deb
rm multimc.deb

# woohoo! nvidia driver hack that may or may not fix a blank screen issue
# that may or may not exist!
# apt purge -y *nvidia*
# ubuntu-drivers autoinstall

# fix for snaps not showing in kde https://forum.snapcraft.io/t/desktop-snaps-do-not-appear-in-the-dash-menu-on-gnome-in-17-10-final-beta/2340/12
mkdir -p ~/.config/environment.d
echo "PATH=$PATH:/snap/bin\nXDG_DATA_DIRS=\"${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:/var/lib/snapd/desktop\"" > ~/.config/environment.d/60-snap-icons-and-bin.conf

# Install WoeUSB-ng
sudo apt install -y git p7zip-full python3-pip python3-wxgtk4.0 grub2-common grub-pc-bin
git clone https://github.com/WoeUSB/WoeUSB-ng.git
cd WoeUSB-ng
sudo pip3 install .
# The following lines should happen automatically in the woe installer
# sudo mv WoeUSB/woeusbgui /usr/local/bin
# sudo mv WoeUSB/woeusb /usr/local/bin
cd ../
rm -rf WoeUSB-ng

# Install key remaps with keyd
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd
echo "\
[ids]
*
[main]
capslock=leftcontrol
leftcontrol=leftalt
leftalt=esc\
backslash=underscore
rightalt=backslash
" > /etc/keyd/default.conf
cd ../
rm -rf keyd

# install firefox
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
# Extract the fingerprint
fingerprint=$(gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | \
awk '/pub/{getline; gsub(/^ +| +$/, ""); print}')
# Expected fingerprint
expected="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"
if [[ "$fingerprint" == "$expected" ]]; then
    echo -e "\nThe key fingerprint matches ($fingerprint).\n"
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | \
    sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
    sudo tee /etc/apt/preferences.d/mozilla > /dev/null <<EOF
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF
    sudo apt-get update && sudo apt-get install firefox
else
    echo -e "\nVerification failed: the fingerprint ($fingerprint) does not match the expected one ($expected).\nYou will need to retry your Firefox install.\n"
fi

# Open pages for each plugin that you normally install in firefox
addon_pages=(
    "https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/darkreader/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/enhancer-for-youtube/"
    "https://addons.mozilla.org/en-US/firefox/addon/epubreader/"
    "https://addons.mozilla.org/en-US/firefox/addon/facebook-container/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/"
    "https://addons.mozilla.org/en-US/firefox/addon/open-url-in-container/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/tranquility-1/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/youtube-audio/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
    "https://addons.mozilla.org/en-US/firefox/addon/user-agent-string-switcher/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
)

for url in "${addon_pages[@]}":
do
    :
    firefox "$url"&
done

sudo apt autoremove
cd ~

# Options
chmod +x options/*
options/natural_scrolling.sh
options/pinyin_support.sh
options/wallpapers.sh
