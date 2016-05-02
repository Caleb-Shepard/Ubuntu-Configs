# ~/.bashrc
# OSX only

# If not running interactively, don't do anything
[ -z "$PS1" ] && return 

command_exists () { #to see if a program is installed
    type "$1" &> /dev/null ;
}

stty -echoctl

# term initializations
PS1="\[\e[0;1;34m\][\$(date +%R)] \[\e[00;01;32m\]${darwin_chroot:+($darwin_chroot)}\u@\h\[\e[01;34m\]:\w\[\e[01;32m\] \$ "
echo -e "\x1b[1;1H\x1b[J"   #clear the screen after exec bash is run

#If you have cowsay and fortune, then you will have a cow saying something on startup
if command_exists cowsay && command_exists fortune && command_exists lolcat ; then
    clear; fortune | cowsay -f tux | lolcat
    alias home='cd; clear; fortune | cowsay | lolcat'
elif command_exists cowsay && command_exists fortune ; then
    clear; fortune | cowsay -f tux
    alias home='cd; clear; fortune | cowsay'
else
    alias home='cd; clear'
fi

# hard screen clear
bind -x '"\C-t": printf "\ec"'

# ls options
alias l='ls'
alias la='ls -AF'
alias ll='ls -lAF'
alias cl='clear; ls'
alias cls='clear; ls'
alias cla='clear; la'
alias cll='clear; ll'
alias ld='clear; ls -1v '

#customize these ls options
alias lso='clear; echo -e "\e[31mSorting from char 10 by default:\n" ; ls -1 | sort -n -k 1.10; echo -e ""'
alias lsao='clear; echo -e "\e[31mSorting from char 10 by default:\n"; ls -lAF -1 | sort -n -k 1.10; echo -e ""'

# grep options
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# vim aliases
alias vb='vim ~/.bashrc && source ~/.bashrc'
alias vv='vim ~/.vimrc'
alias vh='cd /etc; printf "Elevated privileges are required to edit the hosts file! Enter <sudo hosts> to edit it.\n"'

#mistake aliases
alias cim='vim' #common typo
alias vmi='vim' #another common typo
alias vat='echo "Try cat."'

# edit aliases
alias obr='open -e ~/.bashrc && source ~/.bashrc'
alias ovr='open -e ~/.vimrc'
alias oe='open -e'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000 

# append to the history file, don't overwrite it
shopt -s histappend 

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" 

# alerts
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias emergency='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#general aliases for easier use
alias c='clear'
alias pg='ping google.com'

#cd aliases
alias top='cd /'
alias desk='cd ~/Desktop/'
alias docs='cd ~/Documents/'
alias sc='cd ~/Scripts/'
alias work='cd ~/Workspace/'
alias apps='cd ~/Applications/'
alias tools='cd ~/Tools/'

#program aliases
alias py='python'
alias gg='g++'
alias jc='javac'
alias ja='java'
alias eclipse='cd ~/eclipse/java-latest-released/Eclipse.app/Contents/MacOS; (./eclipse&); cd -'
alias firefox='cd ~/Applications/Firefox.app/Contents/MacOS; (./firefox&); cd -'

#miscellaneous aliases
alias invisclear='echo -e "\x1b[1;1H\x1b[J"'
alias strace='echo -e "Try sudo dtruss."'
alias refreshDock='killall Dock; rm ~/Library/Application\ Support/Dock/*.db; killall Dock'
alias diskSpace='df -h'
alias lsnet='networksetup -listallnetworkservices'
alias lssetuid='find / -perm -04000 -ls'
alias lssetgid='find / -perm -02000 -ls'
alias ipv6kill='networksetup -setv6off ' #networksetup -setv6off <device> //devices are listed with lsnet
alias killbluet='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.blued.plist'
alias killrc='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RemoteUI.plist; sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RemoteDesktop.plist; sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RemoteDesktop.PrivilegeProxy.plist; sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RFBEventHelper.plist'
alias killnis='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.nis.ypbind.plist'
alias killisight='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.IIDCAssistant.plist'
alias killwebdav='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.webdavfs_load_kext.plist'
alias killmail='sudo launchctl unload -w /System/Library/LaunchDaemons/org.postfix.master'
alias killnotif='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.UserNotificationCenter.plist'
alias killvpn='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.racoon.plist'
alias killcups='sudo launchctl unload -w /System/Library/LaunchDaemons/org.cups.cups-lpd.plist; sudo launchctl unload -w /System/Library/LaunchDaemons/org.cups.cupsd.plist'
alias killset='chmod ug-s ' #chmod ug-s <programname>
alias killseteasy='chmod ug-s /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/MacOS/ARDAgent; chmod ug-s /System/Library/Printers/IOMs/LPRIOM.plugin/Contents/MacOS/LPRIOMHelper; chmod ug-s /sbin/mount_nfs; chmod ug-s /usr/bin/at; chmod ug-s /usr/bin/atq; chmod ug-s /usr/bin/atrm; chmod ug-s /usr/bin/chpass; chmod ug-s /usr/bin/chrontab' #kill set gid and uid on what's usually nonessential
alias killbonad='sudo defaults write /System/Library/ LaunchDaemons/com.apple.mDNSResponder ProgramArguments -array-add "-NoMulticastAdvertisements"; echo "Bring system down for reboot for changes to take effect!"'
alias rmmic='rm /System/Library/Extensions/'
alias rmairport='rm /System/Library/Extensions/'
alias rmbluet='rm /System/Library/Extensions/IOBluetoothHIDDriver.kext rm /System/Library/Extensions/IOBluetoothFamily.kext'

#methods
weather(){ 
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<your zip code>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';
} #Enter your zip code! After changing it, this method will pull weather forecasts for your area.

#if(bash completion is installed) we will enable it
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
