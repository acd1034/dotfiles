GREEN := \033[0;32m
CYAN := \033[0;36m
NC := \033[0m # No Color

# 変数の定義
TARGET_DIR := $(HOME)

# 対象とするパッケージ（ディレクトリ名）
PACKAGES := prezto ghostty git

.PHONY: update
update: ## dotfilesをシンボリックリンクで配置
	stow -v -R -t $(TARGET_DIR) $(PACKAGES)
	@printf "$(GREEN)Done!$(NC)\n"

.PHONY: remove
remove: ## シンボリックリンクを削除
	stow -v -D -t $(TARGET_DIR) $(PACKAGES)
	@printf "$(GREEN)Done!$(NC)\n"

.DEFAULT_GOAL := help
.PHONY: help
help: ## 使い方を表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(CYAN)%-30s$(NC) %s\n", $$1, $$2}'
