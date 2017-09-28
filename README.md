# configs and more #
### Adapted and modified for OSX usage from dylnmc's config files ###
-- See dylnmc's dotfiles repository for a much more complete, well maintained, and informative experience with configuration files. 
-- If you are a Linux user, these files may not be for you. These configs are tailored for OSX and may be incompatible.

## Within this repository are configuration files for the following ##
- .bashrc              - bash profile (sourced for new bash shell)
- .vimrc               - vim profile (sourced when vim is started)
- .zshrc               - zsh profile (sourced for new zsh shell)

## Places to put the configs ##
- .bashrc
    * `ln -s` to "$HOME/.bashrc"
- .vimrc
    * `ln -s` to "$HOME/.vimrc"
- .zshrc
    * `ln -s` to "$HOME/.zshrc"

## Usages ##
- .bashrc
  * The bashrc file can be used for any terminal device - such as a native terminal or a terminal emulator - that is running a bash (or even an sh) shell. For more information, you can read the bash manual (`man bash` or https://www.gnu.org/software/bash/manual/bash.html)
- .vimrc
    * vim configuration file sourced when vim is run
- .zshrc
    * zsh configuration file that is sourced when zsh is run

## bashrc ##
###Information on the .bashrc###
This .bashrc is designed to be adaptable and usable across different terminals in Linux and UNIX based operating systems.
Your .bashrc should be created inside of your home folder.
  ~/.bashrc

This script is tested primarily in OSX, Arch Linux, and Ubuntu. Testing in other operating systems and terminals not explicitly named in the .bashrc may be sporadic, and full support for those operating systems will not be guaranteed.

When using this script in OSX, be sure to run the command "exec bash" on terminal startup. On Ubuntu, this may be the default behavior and exec bash will not need to be run by you manually; send text at start 'exec bash; echo -e "\x1b[1;1H\x1b[J"' or 'exec bash; clear' for the best results. Note: 'exec bash; clear' will show up in history after startup.

Any program aliases included will not work if the programs and dependencies required are not installed on your system. Many modern terminals will automatically offer to fix this.

## Authors ##
Caleb-Shepard
dylnmc
