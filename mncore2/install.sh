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

# ホームディレクトリに移動
cd "${HOME}"
log_info "Pwd: $(pwd)"

# prezto
log_info "Installing prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
git config --global --add safe.directory "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^(zpreztorc|zshrc|README.md)(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -sfnv "${ZDOTDIR:-$HOME}"/.dotfiles/mncore2/.zpreztorc "${ZDOTDIR:-$HOME}"/.zpreztorc
ln -sfnv "${ZDOTDIR:-$HOME}"/.dotfiles/mncore2/.zshrc "${ZDOTDIR:-$HOME}"/.zshrc

# TODO: fzf
# log_info "Installing fzf..."
# $(brew --prefix)/opt/fzf/install --all

# codex
curl -fsSL https://chatgpt.com/codex/install.sh | sh

log_success "Finished!"
tput bel
