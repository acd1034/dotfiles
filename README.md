# dotfiles

## Prerequisites

```sh
xcode-select --install
```

## Install

```sh
cd ~
curl -fsSL -o install.sh https://raw.githubusercontent.com/acd1034/dotfiles/main/install.sh
zsh install.sh && rm -f install.sh
```

## Update symbolic links

```sh
git clone git@github.com:acd1034/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make update
```
