#!/usr/bin/env zsh
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
log_success() {
  echo -e "${GREEN}$1"
}
log_info() {
  echo -e "${CYAN}[INFO]${NC} $1"
}

# 失敗したらスクリプトを終了
set -euo pipefail

# sudo keep-alive
# TODO: does not work well
log_info "Requesting sudo..."
sudo -v
while true; do
  sudo -n true
  sleep 150
  kill -0 "$$" || exit
done 2>/dev/null &

# ホームディレクトリに移動
cd "$HOME"
log_info "Pwd: $(pwd)"

# Homebrew
log_info "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# prezto
log_info "Installing prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^(zpreztorc|zprofile|zshrc|README.md)(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Brew bundle
log_info "Installing from Brewfile..."
curl -fsSL -o Brewfile https://raw.githubusercontent.com/acd1034/dotfiles/main/Brewfile
brew bundle --file=Brewfile || true
rm -f Brewfile

# fzf
log_info "Installing fzf..."
$(brew --prefix)/opt/fzf/install --all

log_success "Finished!"
tput bel
