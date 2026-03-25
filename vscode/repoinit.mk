define log_success
	@printf "\033[0;32m[SUCCESS]\033[0m %s\n" "$(1)"
endef

SRC := $(HOME)/.dotfiles/vscode
DEST := .

# -R: 再帰的, -v: 詳細表示, -i: 上書き前に確認
.PHONY: python
python: ## Python開発環境を初期化
	cp -i $(SRC)/python/gitignore $(DEST)/.gitignore
	mkdir -p $(DEST)/.vscode
	cp -i $(SRC)/python/*.json $(DEST)/.vscode/
	cp -i $(SRC)/python/vscode_gitignore $(DEST)/.vscode/.gitignore
	$(call log_success,Done!)

.DEFAULT_GOAL := help
.PHONY: help
help: ## 使い方を表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[0;36m%-24s\033[0m %s\n", $$1, $$2}'
