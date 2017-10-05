plugins=(git)

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# OSX Emacs LDFLAGS
LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

# term initializations
echo -e "\x1b[1;1H\x1b[JRunning zsh as $(whoami)\n$(pwd)"
fortune | cowsay | lolcat
echo

alias cl='echo "$(clear)Running zsh as $(whoami)\n$(pwd)"; ls -GA'
alias cls='echo "$(clear)Running zsh as $(whoami)\n$(pwd)"; ls -G'
alias cla='echo "$(clear)Running zsh as $(whoami)\n$(pwd)"; ls -AFG'
alias cll='echo "$(clear)Running zsh as $(whoami)\n$(pwd)"; ll -AFG | less'
alias l='ls -G'
alias la='ls -AG'
