# 変数の定義
TARGET_DIR   := $(HOME)

# 対象とするパッケージ（ディレクトリ名）
PACKAGES := prezto ghostty git

.PHONY: update
update: ## dotfilesをシンボリックリンクで配置
	@echo "Updating dotfiles..."
	@for package in $(PACKAGES); do \
		stow -v -R -t $(TARGET_DIR) $$package; \
	done
	@echo "Done!"

.PHONY: remove
remove: ## リンクを削除（管理解除）
	@echo "Removing dotfiles..."
	@for package in $(PACKAGES); do \
		stow -v -D -t $(TARGET_DIR) $$package; \
	done
	@echo "Done!"

.DEFAULT_GOAL := help
.PHONY: help
help: ## 使い方を表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
