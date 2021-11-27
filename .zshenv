export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/Library/Apple/usr/bin

# Initialize and configure nvm (Node Version Manager)
# This lives here instead of .zshrc because we want node even in some non-interative shell contexts
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
