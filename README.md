# configs and more #
### Mac OS ###

## Within this repository are configuration files for the following ##
- .bashrc              - bash profile (sourced for new bash shell)
- .vimrc               - vim profile (sourced when vim is started)
- .zshrc               - zsh profile (sourced for new zsh shell)

## Places to put the configs ##
After
```
git clone https://github.com/Caleb-Shepard/configs; cd configs/dotfiles
cp .bashrc ~/.bashrc
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
```

## Usages ##
- .bashrc
    * bourne again shell configuration file sourced on launch
- .vimrc
    * vim configuration file sourced when vim is run
- .zshrc
    * zsh configuration file sourced on launch

## bashrc ##
### Information on the .bashrc ###
Your .bashrc should be created inside of your home folder.
~/.bashrc

When using this script in Mac OS, you may run the command "exec bash" or /bin/bash on terminal startup to launch the bash shell. On Ubuntu, this may be the default behavior and exec bash will not need to be run by you manually; send text at start 'exec bash; echo -e "\x1b[1;1H\x1b[J"' or 'exec bash; clear' for the best results. Note: 'exec bash; clear' will show up in history after startup.

Any aliases pointing to programs not included in coreutils may not work if the programs and dependencies required are not installed on your system. Many modern terminals will automatically offer to fix this.

![bash_shell](img/screenshot.png?raw=true "Bash Shell")

## Authors ##
Caleb-Shepard
dylnmc
