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

# Init pyenv
eval "$(pyenv init -)"

# Aliases
alias ll='ls -alGph'
alias dotfile-git='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Env variables

## Python
export PIPENV_VENV_IN_PROJECT=true
export VIRTUAL_ENV_DISABLE_PROMPT=true
export PIPENV_IGNORE_VIRTUALENVS=true
export PIPENV_DEFAULT_PYTHON_VERSION=$PYENV_ROOT/shims/python

## OpenSSL Linking
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
