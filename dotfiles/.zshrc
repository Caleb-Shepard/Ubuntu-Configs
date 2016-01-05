
export GRML_DISPLAY_BATTERY=1;
if ! grep -q "$HOME/scripts" <<< $PATH; then
    export PATH="$HOME/scripts:$PATH";
fi;

# start "work" tmux session if not started. Also, if not attached, attach it. This only happens in graphical environment
if [[ -n $DISPLAY ]]; then
    tmSessions="$(tmux ls)";
    if ! grep -q 'work' <<< $tmSessions; then
        tmux -2 new -s work 2>/dev/null;
    elif grep -q 'work' <<< $tmSessions && ! grep -q 'attached' <<< $(grep 'work' <<< $tmSessions); then
        tmux -2 attach-session -t work;
    fi;
fi;

# Give a nice little greeting based on the time of day
if [[ $(date "+%H") -lt 6 ]]; then
    TIME_OF_DAY="GO TO BED";
elif [[ $(date "+%H") -lt 12 ]]; then
    TIME_OF_DAY="Good morning";
elif [[ $(date "+%H") -gt 7 ]]; then
    TIME_OF_DAY="Good evening";
else
    TIME_OF_DAY="Good afternoon";
fi;
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

eval $(dircolors ~/.dircolors);

source /etc/profile.d/vte.sh 2>/dev/null;

## quick aliases
alias tm='tmux -2'
alias vb='f=$(readlink -f $HOME/.bashrc); cd ${f:h}; vim $f; cd - > /dev/null; if [ "$(echo $BASH_VERSION)" ]; then source $HOME/.bashrc; fi'
alias vz='f=$(readlink -f $HOME/.zshrc); cd ${f:h}; vim $f; cd - > /dev/null; if [ "$(echo $ZSH_VERSION)" ]; then source $HOME/.zshrc; fi'
alias vv='f=$(readlink -f $HOME/.vimrc); cd ${f:h}; vim $f; cd - > /dev/null'
alias vnv='f=$(readlink -f $HOME/.config/nvim/init.vim); cd ${f:h}; vim $f; cd - > /dev/null'
alias vt='f=$(readlink -f $HOME/.tmux.conf); cd ${f:h}; vim $f; cd - > /dev/null'
alias vi3='f=$(readlink -f $HOME/.i3/config); cd ${f:h}; vim $f; cd - > /dev/null'
alias vi3s='f=$(readlink -f $HOME/.i3status.conf); cd ${f:h}; vim $f; cd - > /dev/null'
alias vi3b='f=$(readlink -f $HOME/.i3blocks.conf); cd ${f:h}; vim $f; cd - > /dev/null'

# use the vi navigation keys (hjkl) besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

# set command prediction from history, see 'man 1 zshcontrib'
is4 && zrcautoload predict-on && \
zle -N predict-on         && \
# zle -N predict-off        && \
bindkey "^X^Z" predict-on && \
bindkey "^Z" predict-off

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

