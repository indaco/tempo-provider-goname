# Regular colors
color_red     := $(shell printf "\e[31m")  # Red color
color_green   := $(shell printf "\e[32m")  # Green color
color_yellow  := $(shell printf "\e[33m")  # Yellow color
color_blue    := $(shell printf "\e[34m")  # Blue color
color_magenta := $(shell printf "\e[35m")  # Magenta color
color_cyan    := $(shell printf "\e[36m")  # Cyan color

# Bold variants
color_bold_red     := $(shell printf "\e[1;31m")  # Bold red color
color_bold_green   := $(shell printf "\e[1;32m")  # Bold green color
color_bold_yellow  := $(shell printf "\e[1;33m")  # Bold yellow color
color_bold_blue    := $(shell printf "\e[1;34m")  # Bold blue color
color_bold_magenta := $(shell printf "\e[1;35m")  # Bold magenta color
color_bold_cyan    := $(shell printf "\e[1;36m")  # Bold cyan color
color_reset        := $(shell printf "\e[0m")     # Reset to default color

# Go commands
GO := go
GOCLEAN := $(GO) clean

# ==================================================================================== #
# HELPERS
# ==================================================================================== #
.PHONY: help
help: ## Print this help message
	@echo ""
	@echo "Usage: make [action]"
	@echo ""
	@echo "Available Actions:"
	@echo ""
	@awk -v green="$(color_green)" -v reset="$(color_reset)" -F ':|##' \
		'/^[^\t].+?:.*?##/ {printf " %s* %-15s%s %s\n", green, $$1, reset, $$NF}' $(MAKEFILE_LIST) | sort
	@echo ""

# ==================================================================================== #
# PUBLIC TASKS
# ==================================================================================== #
.PHONY: all
all: clean test

.PHONY: clean
clean: ## Clean the build directory and Go cache
	@echo "$(color_bold_cyan)* Clean the Go cache$(color_reset)"
	$(GOCLEAN) -cache
	$(GOCLEAN) -testcache

.PHONY: test
test: ## Run all tests and generate coverage report.
	@echo "$(color_bold_cyan)* Run all tests and generate coverage report.$(color_reset)"
	@$(GO) test -count=1 -timeout 30s ./... -coverprofile=coverage.out
	@echo "$(color_bold_cyan)* Total Coverage$(color_reset)"
	@$(GO) tool cover -func=coverage.out | grep total | awk '{print $$3}'

.PHONY: test/coverage
test/coverage: ## Run go tests and use go tool cover.
	@echo "$(color_bold_cyan)* Run go tests and use go tool cover$(color_reset)"
	@$(MAKE) test
	@$(GO) tool cover -html=coverage.out

# catch-all rule: do nothing for undefined targets instead of throwing an error
%:
	@:
