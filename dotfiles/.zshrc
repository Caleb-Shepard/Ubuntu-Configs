#Modification of dylnmc's .zshrc for OSX use
#See https://github.com/dylnmc/dotfiles/blob/master/dotfiles/.zshrc for his work on the Master branch (designed for use with i3 in Arch Linux) 
export GRML_DISPLAY_BATTERY=1;
if ! grep -q "$HOME/scripts" <<< $PATH; then
    export PATH="$HOME/scripts:$PATH";
fi;

command_exists () { #to see if a program is installed
    type "$1" &> /dev/null ;
}

# term initializations
clear   #clear the screen after exec zsh is run

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

# print the greeting using figlet (if that doesn't exists, it will just use echo)
i=$(($RANDOM % 5 + 1)); # random number {1..6}
while IFS='' read -r line; do
    printf "\033[3${i};1m$line\033[0m\n";
    ((i++));
    if [[ $i -eq 7 ]]; then
        i=1;
    fi;
done <<< $(figlet -tf big "${TIME_OF_DAY}, ${USER}." 2>/dev/null) || echo "${TIME_OF_DAY}, ${USER}";

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

RANGER_LOAD_DEFAULT_RC="FALSE";

source /etc/profile.d/vte.sh 2>/dev/null;

# edit aliases
alias tm='tmux -2'
alias vb='vim ~/.bashrc'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias vt='vim ~/.tmux.conf'
alias vh='cd /etc; printf "Elevated privileges are required to edit the hosts file! Enter <sudo hosts> to edit it.\n"'
alias cim='vim' #common typo
alias obr='open -e ~/.bashrc && source ~/.bashrc'
alias ovr='open -e ~/.vimrc'
alias oe='open -e'

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

#program aliases
alias py='python'
alias gg='g++'
alias jc='javac'
alias ja='java'
alias eclipse='cd ~/eclipse/java-latest-released/Eclipse.app/Contents/MacOS; (./eclipse&); cd -'

#cd aliases
alias top='cd /'
alias desk='cd ~/Desktop/'
alias docs='cd ~/Documents/'
alias sc='cd ~/Scripts/'
alias work='cd ~/Workspace/'
alias apps='cd ~/Applications/'

#other aliases
alias home='cd; clear; fortune | cowsay -f dragon | lolcat -s 1'
alias c='clear'
alias pg='ping google.com'

# set command prediction from history, see 'man 1 zshcontrib'
zle -N predict-on         && \

# define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
WORDCHARS='${WORDCHARS:s@/@}'

## try to avoid the 'zsh: no matches found...'
setopt nonomatch

# don't warn me about bg processes when exiting
setopt nocheckjobs

# the default grml setup provides '..' as a completion. it does not provide
# '.' though. If you want that too, use the following line:
zstyle ':completion:*' special-dirs true

#if(zsh completion is installed) we will enable it
if [ -f $(brew --prefix)/etc/zsh_completion ]; then
    . $(brew --prefix)/etc/zsh_completion
fi
