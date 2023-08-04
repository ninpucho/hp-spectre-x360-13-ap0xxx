 Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tbaker78/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
prompt walters

# Created by newuser for 5.9
eval "$(starship init zsh)"
neofetch

# Sources
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias update_grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias package-upgrade="yay -Syu"

