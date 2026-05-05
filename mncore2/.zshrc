#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
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

# aliases
alias amend='git commit --amend --no-edit'
alias beep='tput bel'
alias jpeg='mkdir -p jpeg && sips -s format jpeg *.* --out jpeg/'
alias echopath='echo $PATH | tr ":" "\n"'
alias gedit='code "${HOME}/.config/ghostty/config"'
alias repoinit='make -f "${HOME}/.dotfiles/vscode/repoinit.mk"'
# TODO
# alias ls='eza'
# alias grep='rg'
# eval "$(zoxide init zsh --cmd cd)" # cd='zoxide'

# fzf
[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh" # keybindings for fzf
