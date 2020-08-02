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

#####
# TOOL INITS
#####

# Start ssh-agent in background
eval "$(ssh-agent -s)"

# Init Starship prompt
eval "$(starship init zsh)"

# Init pyenv
eval "$(pyenv init -)"

#####
# FUNCTION DECLARATIONS
#####

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

git-is-gitflow() {
    # Returns with 0 error status if a branch called "develop" exists.
    git show-ref --verify --quiet refs/heads/develop
    if [[ $? -eq 0 ]] ; then
        return 0
    else
        return 1
    fi
}

git-get-primary-branch() {
    # Returns "master" unless we're in a GitFlow project, tested by presence of a "develop" branch.
    if git-is-gitflow ; then
        echo 'develop'
    else
        echo 'master'
    fi
}

git-checkout-and-delete() {
    # Checks out the branch from first argument, and deletes branch from second argument.
    if [[ $2 == 'master' || $2 == 'develop' ]] ; then
        echo "Will not perform destructive action against primary branch $2."
        return 1
    fi
    git checkout $1 && git pull && git branch -D $2
}

git-push-upstream() {
    # Pushes current branch to upstream origin with same name
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream origin $current_branch
}

git-delete-merged() {
    # Deletes current branch that has presumably been merged upstream.
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    primary_branch=$(git-get-primary-branch)
    git-checkout-and-delete $primary_branch $current_branch
}

git-merge-latest-primary() {
    # Pulls and merges latest changes from primary branch into active branch.
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    primary_branch=$(git-get-primary-branch)
    git checkout $primary_branch && git pull && git checkout $current_branch && git merge $primary_branch
}

git-new-branch-off-active() {
    # Checks out a new branch off of the current active branch.
    git checkout -b $1
}

git-new-branch-off-primary () {
    # Checks out a new branch off of the latest version of primary branch.
    primary_branch=$(git-get-primary-branch)
    git checkout $primary_branch && git pull && git checkout -b $1
}

#####
# ALIASES
#####
alias ll='ls -alGph'
alias dotfile-git="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias gpu='git-push-upstream'
alias gdm='git-delete-merged'
alias gmlp='git-merge-latest-primary'
alias gnb='git-new-branch-off-active'
alias gnbp='git-new-branch-off-primary'

#####
# ENV VARS
#####

## Python
export PIPENV_VENV_IN_PROJECT=true
export VIRTUAL_ENV_DISABLE_PROMPT=true
export PIPENV_IGNORE_VIRTUALENVS=true
export PIPENV_DEFAULT_PYTHON_VERSION=$PYENV_ROOT/shims/python

## OpenSSL Linking
export LDFLAGS='-L/usr/local/opt/openssl/lib'
export CPPFLAGS='-I/usr/local/opt/openssl/include'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/will/apps/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/will/apps/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/will/apps/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/will/apps/google-cloud-sdk/completion.zsh.inc'; fi
