#!/usr/bin/env zsh
# ============================================================================
# dock.sh — rebuild the macOS Dock from a fixed app list (idempotent).
# Requires dockutil (installed by homebrew.sh). Apps not installed are skipped,
# so it is safe to run on a partially-provisioned machine.
# ============================================================================

if ! command -v dockutil >/dev/null 2>&1; then
	echo "dockutil not found — run ./homebrew.sh first (brew install dockutil)." >&2
	exit 1
fi

# Left-to-right order. Finder is always the leftmost item (not listed here).
# Standard macOS apps first, then the curated GUI apps. codex is a CLI (no .app).
apps=(
	"/Applications/Google Chrome.app"
	"/Applications/iTerm.app"
	"/System/Applications/System Settings.app"
	"/Applications/1Password.app"
	"/Applications/ChatGPT.app"
	"/Applications/Claude.app"
	"/Applications/TablePlus.app"
	"/Applications/Docker.app"
	"/Applications/Rectangle.app"
)

echo "==> clearing Dock"
dockutil --remove all --no-restart >/dev/null

for app in "${apps[@]}"; do
	if [[ -d "$app" ]]; then
		dockutil --add "$app" --no-restart >/dev/null && echo "  + ${app:t:r}"
	else
		echo "  - skip (not installed): ${app:t:r}"
	fi
done

killall Dock
echo "==> Dock rebuilt."
