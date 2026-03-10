#!/usr/bin/env zsh
log_error() {
  printf "\033[0;31m[ERROR]\033[0m %s\n" "$1"
}
log_success() {
  printf "\033[0;32m[SUCCESS]\033[0m %s\n" "$1"
}
log_warning() {
  printf "\033[0;33m[WARNING]\033[0m %s\n" "$1"
}
log_info() {
  printf "\033[0;36m[INFO]\033[0m %s\n" "$1"
}

# 失敗したらスクリプトを終了
set -euo pipefail

# sudoを維持
# TODO: does not work well
keep_sudo_alive() {
  log_info "Requesting sudo..."
  sudo -v
  while true; do
    sudo -n true
    sleep 150
    kill -0 "$$" || exit
  done 2>/dev/null &
}
keep_sudo_alive

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
