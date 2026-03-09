#!/usr/bin/env zsh
CYAN='\033[0;36m'
NC='\033[0m' # No Color
log_info() {
  echo -e "${CYAN}[INFO]${NC} $1"
}

# 失敗したらスクリプトを終了
set -euo pipefail

# スクリプトのあるディレクトリに移動
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
log_info "Pwd: $(pwd)"

# dotfiles
log_info "Installing dotfiles..."
make update

# prezto
log_info "Installing prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  [[ -e "${SCRIPT_DIR}/prezto/.${rcfile:t}" ]] && continue
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Brew bundle
log_info "Installing from Brewfile..."
brew tap Homebrew/bundle
brew bundle --file=${SCRIPT_DIR}/Brewfile

# fzf
log_info "Installing fzf..."
$(brew --prefix)/opt/fzf/install --all

# TeX Live
log_info "Setting up TeX Live..."
sudo tlmgr update --self --all
sudo tlmgr paper a4
sudo tlmgr repository add http://contrib.texlive.info/current tlcontrib
sudo tlmgr pinning add tlcontrib '*'
sudo tlmgr install japanese-otf-nonfree japanese-otf-uptex-nonfree ptex-fontmaps-macos cjk-gs-integrate-macos
sudo cjk-gs-integrate --link-texmf --cleanup
sudo cjk-gs-integrate-macos --link-texmf
sudo mktexlsr
sudo kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron
