define log_success
	@printf "\033[0;32m[SUCCESS]\033[0m %s\n" "$(1)"
endef

DEST := .

.PHONY: python
python: SRC := $(HOME)/.dotfiles/vscode/python
python: ## Python開発環境を初期化
	-cp -i $(SRC)/gitignore $(DEST)/.gitignore
	mkdir -p $(DEST)/.vscode
	-cp -i $(SRC)/*.json $(DEST)/.vscode/
	-cp -i $(SRC)/vscode_gitignore $(DEST)/.vscode/.gitignore
	$(call log_success,Done!)

# -s: ハードリンクではなくシンボリックリンク, -i: 上書き前に確認, -n: 既存のリンクがあっても中身を追わずに強制的に置き換え
.PHONY: mncore2
mncore2: SRC := /mnt/pvc-home/rhirakida/pfcomp/.vscode
mncore2: ## mncore2
	mkdir -p $(DEST)/.vscode
	-cp -i $(SRC)/*.json $(DEST)/.vscode/
	-cp -i $(SRC)/.gitignore $(DEST)/.vscode/.gitignore
	-ln -sin $(SRC)/.env $(DEST)/.vscode/.env
	$(call log_success,Done!)

.PHONY: mncore2-local
mncore2-local: ## mncore2-local
	-ln -sin $(HOME)/Documents/programs/LOCAL-rhirakida-pfcomp/.venv $(DEST)/.venv
	$(call log_success,Done!)

.DEFAULT_GOAL := help
.PHONY: help
help: ## 使い方を表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[0;36m%-24s\033[0m %s\n", $$1, $$2}'
