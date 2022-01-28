#!/usr/bin/bash

cd ~
# Add npm keys to apt
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# Add signal desktop keys to apt
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | "sudo tee -a /etc/apt/sources.list.d/signal-xenial.list"

# Update package managers
sudo apt update -y
sudo apt dist-upgrade -y

# ! Install packages 
apt_packages=(
    "firefox",          # Firefox will become a snap package soon
    "openjdk-17-jdk",
    "curl",
    "gradle",
    "xclip",
    "dc3dd",
    "zsh",
    "nmap",
    "lolcat",
    "cowsay",
    "fortune",
    "vim",
    "youtube-dl",
    "gparted",
    "pythonpy",
    "xmodmap",
    "tmux",
    "gimp",
    "build-essential",
    "nodejs",
    "signal-desktop"
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
    "bitwarden",
    "telegram-desktop",
    "slack",
    "gh"
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


# ! Move dotfiles
mv Ubuntu-Configs/dotfiles* ~/


# ! add xmodmap sourcing to your login profile
touch ~/.xinitrc
echo "xmodmap ~/.Xmodmap" >> ~/.xinitrc


# install multimc
sudo apt --fix-broken install; sudo apt install -y libqt5widgets* libqt5gui* libqt5network* libqt5core* libqt5xml* libqt5concurrent; sudo apt --fix-broken install
curl https://files.multimc.org/downloads/multimc_1.6-1.deb -o multimc.deb && sudo dpkg -i multimc.deb

# woohoo! nvidia driver hack that may or may not fix a blank screen issue
# that may or may not exist!
# apt purge -y *nvidia*
# ubuntu-drivers autoinstall

# Install WoeUSB-ng
sudo apt install git p7zip-full python3-pip python3-wxgtk4.0 grub2-common grub-pc-bin
git clone https://github.com/WoeUSB/WoeUSB-ng.git
cd WoeUSB-ng
sudo pip3 install .
# The following lines should happen automatically in the woe installer
# sudo mv WoeUSB/woeusbgui /usr/local/bin
# sudo mv WoeUSB/woeusb /usr/local/bin
cd

# Open pages for each plugin that you normally install in firefox
addon_pages=(
    "https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search",
    "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search",
    "https://addons.mozilla.org/en-US/firefox/addon/darkreader/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search",
    "https://addons.mozilla.org/en-US/firefox/addon/enhancer-for-youtube/",
    "https://addons.mozilla.org/en-US/firefox/addon/epubreader/",
    "https://addons.mozilla.org/en-US/firefox/addon/facebook-container/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search",
    "https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/",
    "https://addons.mozilla.org/en-US/firefox/addon/open-url-in-container/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search",
    "https://addons.mozilla.org/en-US/firefox/addon/tranquility-1/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search",
    "https://addons.mozilla.org/en-US/firefox/addon/youtube-audio/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search"
)

for url in "${addon_pages[@]}":
do
    :
    firefox "$url"&
done

sudo apt autoremove
cd ~