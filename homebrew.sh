#!/usr/bin/env zsh
# ============================================================================
# homebrew.sh — install Homebrew packages (idempotent; safe to re-run).
# `brew` is the native Apple Silicon Homebrew (Intel brew = `ibrew`).
# ============================================================================

# --- CLI / shell environment the dotfiles depend on --------------------------
# (referenced by scripts/aliases.zsh, scripts/aws.zsh, scripts/fzf.zsh, etc.)
brew install \
	git gh \
	ripgrep fd bat neovim \
	gnu-sed coreutils \
	jq fzf \
	tmux byobu \
	dust bottom procs hexyl tokei tree \
	wget tldr lazydocker \
	awscli

# --- Python (pyenv) ----------------------------------------------------------
brew install pyenv pyenv-virtualenv

# --- Casks (driven by scripts/.brew_cask_installed — single source of truth) --
# Edit that file to add / remove apps, then re-run this script.
casks=("${(@f)$(grep -vE '^[[:space:]]*(#|$)' "${0:A:h}/scripts/.brew_cask_installed")}")
brew install --cask "${casks[@]}"
