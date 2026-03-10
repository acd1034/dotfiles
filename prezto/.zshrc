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
log_warning() {
  printf "\033[0;33m[WARNING]\033[0m %s\n" "$1"
}
check_dotfiles_dirty() {
  local dotfiles="$HOME/.dotfiles"
  local dotfiles_text="~/.dotfiles"
  local dotfiles_vscode=$'\033]8;;vscode://file'"$dotfiles"$'\033\\'"$dotfiles_text"$'\033]8;;\033\\'
  [ -d "$dotfiles/.git" ] || return

  # 未コミット変更
  if ! git -C "$dotfiles" diff --quiet HEAD; then
    log_warning "$dotfiles_vscode has uncommitted changes."
  fi

  (
    local dotfiles_check_state="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles_last_check"
    local current_time=$(date +%s)
    local last_check=$(cat "$dotfiles_check_state" 2>/dev/null || echo 0)
    if (( current_time - last_check > 28800 )); then
      # 最終チェック時刻を更新
      echo "$current_time" >| "$dotfiles_check_state"

      # リモート更新を取得
      git -C "$dotfiles" fetch --quiet || return

      # upstreamとの差分
      local counts behind ahead
      counts=$(git -C "$dotfiles" rev-list --left-right --count @{upstream}...HEAD 2>/dev/null) || return
      behind=$(echo "$counts" | awk '{print $1}')
      ahead=$(echo "$counts" | awk '{print $2}')

      if [ "$behind" -gt 0 ]; then
        if ! git -C "$dotfiles" merge --ff-only '@{upstream}' > /dev/null 2>&1; then
          log_warning "Failed to merge remote changes for $dotfiles_vscode."
        fi
      fi

      if [ "$ahead" -gt 0 ]; then
        log_warning "$dotfiles_vscode is $ahead commits ahead of remote."
      fi
    fi
  ) &!
}
check_dotfiles_dirty

# aliases
cp_vspy() {
  local src="$HOME/.dotfiles/vscode/python"
  local dest="./.vscode"

  if [[ ! -d "$src" ]]; then
    log_error "$src does not exist."
    return 1
  fi

  mkdir -p "$dest"
  # コピーの実行（-R: 再帰的, -v: 詳細表示, -i: 上書き前に確認）
  cp -Rvi "$src/"* "$dest/"
}
alias amend='git commit --amend --no-edit'
alias beep='tput bel'
alias jpeg='mkdir -p jpeg && sips -s format jpeg *.* --out jpeg/'
alias echopath='echo $PATH | tr ":" "\n"'
alias gedit='code ~/.config/ghostty/config'
alias ls='eza'
alias grep='rg'
eval "$(zoxide init zsh --cmd cd)" # cd='zoxide'

# fzf
# TODO: --strip-cwd-prefix
export FZF_CTRL_T_COMMAND='fd --max-depth 1 --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="
  --bind 'right:transform(
    if [ -d {} ]; then
      echo \"reload($FZF_CTRL_T_COMMAND --search-path {})\"
    else
      echo \"accept\"
    fi
  )'
  --bind 'left:reload(
    target=\$(dirname \$(dirname {}));
    if [ \"\$target\" = \".\" ]; then
      $FZF_CTRL_T_COMMAND;
    else
      $FZF_CTRL_T_COMMAND --search-path \"\$target\";
    fi
  )'
  --header 'Right: Open / Left: Back'
"
export FZF_ALT_C_COMMAND='fd --max-depth 1 --hidden --follow --exclude .git --type d'
export FZF_ALT_C_OPTS="
  --bind 'right:transform(
    if [ -d {} ]; then
      echo \"reload($FZF_ALT_C_COMMAND --search-path {})\"
    else
      echo \"accept\"
    fi
  )'
  --bind 'left:reload(
    target=\$(dirname \$(dirname {}));
    if [ \"\$target\" = \".\" ]; then
      $FZF_ALT_C_COMMAND;
    else
      $FZF_ALT_C_COMMAND --search-path \"\$target\";
    fi
  )'
  --header 'Right: Open / Left: Back'
"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # keybindings for fzf
