# ~/.bashrc
# OSX only

# If not running interactively, don't do anything
[ -z "$PS1" ] && return 

command_exists () { #to see if a program is installed
    type "$1" &> /dev/null ;
}

# term initializations
PS1="\[\e[0;1;34m\][\$(date +%R)] \[\e[00;01;32m\]${darwin_chroot:+($darwin_chroot)}\u@\h\[\e[01;34m\]:\w\[\e[01;32m\] \$ "
clear   #clear the screen after exec bash is run

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

# grep options
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# vim aliases
alias vb='vim ~/.bashrc && source ~/.bashrc'
alias vv='vim ~/.vimrc'
alias vh='cd /etc; printf "Elevated privileges are required to edit the hosts file! Enter <sudo hosts> to edit it.\n"'
alias cim='vim' #common typo

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

#program aliases
alias py='python'
alias gg='g++'
alias jc='javac'
alias ja='java'
alias eclipse='cd ~/eclipse/java-latest-released/Eclipse.app/Contents/MacOS; (./eclipse&); cd -'
alias pizza='python ~/Scripts/Pizza.py'

#if(bash completion is installed) we will enable it
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
