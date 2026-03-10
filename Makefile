define log_error
	@printf "\033[0;31m[ERROR]\033[0m %s\n" "$(1)"
endef
define log_success
	@printf "\033[0;32m[SUCCESS]\033[0m %s\n" "$(1)"
endef
define log_warning
	@printf "\033[0;33m[WARNING]\033[0m %s\n" "$(1)"
endef
define log_info
	@printf "\033[0;36m[INFO]\033[0m %s\n" "$(1)"
endef

# 変数の定義
TARGET_DIR := $(HOME)

# 対象とするパッケージ（ディレクトリ名）
PACKAGES := prezto ghostty git

# -v: 詳細表示, -R: 再リンク, -t TARGET: ターゲットディレクトリの指定
.PHONY: update
update: ## dotfilesをシンボリックリンクとして配置
	stow -v -R -t $(TARGET_DIR) $(PACKAGES)
	$(call log_success,Done!)

.PHONY: remove
remove: ## シンボリックリンクを削除
	stow -v -D -t $(TARGET_DIR) $(PACKAGES)
	$(call log_success,Done!)

.DEFAULT_GOAL := help
.PHONY: help
help: ## 使い方を表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[0;36m%-24s\033[0m %s\n", $$1, $$2}'
