SHELL := /bin/bash

INSTALLER := ./scripts/install-skills.sh
ENV ?= codex
TARGET ?=
SKILLS ?=
FROM_REPO ?=
REPO_REF ?=
REPO_SUBDIR ?= skills

.PHONY: help list dry-run install install-codex install-claude install-cursor install-antigravity install-from-repo

help:
	@echo "Agnostic-Skills Make targets"
	@echo ""
	@echo "General:"
	@echo "  make list                              # list available local skills"
	@echo "  make dry-run ENV=codex SKILLS='a b'    # simulate install for selected skills"
	@echo "  make install ENV=cursor SKILLS='a b'   # install local skills into an env preset"
	@echo "  make install TARGET=/path SKILLS='a b' # install local skills to explicit target"
	@echo ""
	@echo "Direct env shortcuts:"
	@echo "  make install-codex"
	@echo "  make install-claude"
	@echo "  make install-cursor"
	@echo "  make install-antigravity"
	@echo ""
	@echo "External repo import:"
	@echo "  make install-from-repo ENV=codex FROM_REPO=<git_url> REPO_REF=main REPO_SUBDIR=skills"

list:
	@$(INSTALLER) --list-only

dry-run:
	@args=(); \
	if [[ -n "$(TARGET)" ]]; then args+=(--target "$(TARGET)"); else args+=(--env "$(ENV)"); fi; \
	for s in $(SKILLS); do args+=(--skill "$$s"); done; \
	$(INSTALLER) "$${args[@]}" --dry-run

install:
	@args=(); \
	if [[ -n "$(TARGET)" ]]; then args+=(--target "$(TARGET)"); else args+=(--env "$(ENV)"); fi; \
	for s in $(SKILLS); do args+=(--skill "$$s"); done; \
	$(INSTALLER) "$${args[@]}"

install-codex:
	@$(INSTALLER) --env codex

install-claude:
	@$(INSTALLER) --env claude-code

install-cursor:
	@$(INSTALLER) --env cursor

install-antigravity:
	@$(INSTALLER) --env antigravity

install-from-repo:
	@if [[ -z "$(FROM_REPO)" ]]; then \
		echo "FROM_REPO is required"; \
		exit 1; \
	fi
	@args=(--env "$(ENV)" --from-repo "$(FROM_REPO)" --repo-subdir "$(REPO_SUBDIR)"); \
	if [[ -n "$(REPO_REF)" ]]; then args+=(--repo-ref "$(REPO_REF)"); fi; \
	for s in $(SKILLS); do args+=(--skill "$$s"); done; \
	$(INSTALLER) "$${args[@]}"
