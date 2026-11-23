#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

append_once() {
  touch "$2"
  grep -qxF "$1" "$2" || echo "$1" >> "$2"
}

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
append_once 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile

# Cask apps
brew install --cask caffeine
brew install --cask claude
brew install --cask claude-code
brew install --cask thebrowsercompany-dia
brew install --cask gcloud-cli
brew install --cask google-chrome
brew install --cask grok-bot
brew install --cask hammerspoon
brew install --cask linear
brew install --cask logi-options+
brew install --cask lulu
brew install --cask notion
brew install --cask orbstack
brew install --cask pgadmin4
brew install --cask slack
brew install --cask spotify
brew install --cask telegram
brew install --cask trezor-suite
brew install --cask visual-studio-code
brew install --cask whatsapp
brew install --cask zoom

# Hammerspoon config, linked right after the casks so a later failure cannot skip it
mkdir -p ~/.hammerspoon
ln -sf "$REPO_DIR/hammerspoon/init.lua" ~/.hammerspoon/init.lua

# VS Code extensions (the cask links the `code` CLI into Homebrew's bin)
code --install-extension anthropic.claude-code

# Formulae
brew install awscli
brew install ffmpeg
brew install gh
brew install go
brew install mole
brew install nvm
brew install postgresql@14
brew install pyenv
brew install pyenv-virtualenv
brew install python3
brew install supabase/tap/supabase
brew install uv
brew install weasyprint

# Node (via nvm) and global npm packages
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
. "$(brew --prefix nvm)/nvm.sh" --no-use
nvm install --lts
nvm alias default 'lts/*'
npm install -g --allow-scripts=netlify-cli,pnpm,yarn,esbuild,unix-dgram pnpm yarn vercel netlify-cli

# Shell config
append_once 'export NVM_DIR="$HOME/.nvm"' ~/.zshrc
append_once '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"' ~/.zshrc
append_once 'eval "$(pyenv init --path)"' ~/.zshrc
append_once 'export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"' ~/.zshrc
