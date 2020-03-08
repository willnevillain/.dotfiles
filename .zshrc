# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/will/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Start ssh-agent in background
eval "$(ssh-agent -s)"

# Init Starship prompt
eval "$(starship init zsh)"

# Aliases
alias ll='ls -alGph'

