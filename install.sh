#!/usr/bin/env zsh
CYAN='\033[0;36m'
NC='\033[0m' # No Color
log_info() {
  echo -e "${CYAN}[INFO]${NC} $1"
}

# 失敗したらスクリプトを終了
set -euo pipefail

# sudo keep-alive
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

# Xcode
log_info "Installing Xcode..."
xcode-select --install || true

# Homebrew
log_info "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# prezto
log_info "Installing prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Brew bundle
log_info "Installing from Brewfile..."
curl -fsSL -o Brewfile https://raw.githubusercontent.com/acd1034/dotfiles/main/Brewfile
brew tap Homebrew/bundle
brew bundle --file=Brewfile
rm Brewfile

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

log_info "Finished!"
tput bel
