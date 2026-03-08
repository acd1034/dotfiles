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
alias amend='git commit --amend --no-edit'
alias beep='tput bel; echo "\e]9;Ghostty test (OSC 9)\a"'
alias jpeg='mkdir jpeg && sips -s format jpeg *.* --out jpeg/'
alias ls='eza'
alias ll='eza -hl'
alias la='eza -hla'
alias cat='bat'
alias grep='rg'
alias find='fd'
eval "$(zoxide init zsh --cmd cd)"

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
