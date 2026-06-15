#!/usr/bin/env zsh
# ============================================================================
# bootstrap.sh — one-shot provisioner. Runs the setup scripts in order.
# Assumes Homebrew is already installed (see README).
# ============================================================================
set -e
cd "$(dirname "$0")"

./defaults.sh
./setup.sh
./homebrew.sh
./dock.sh        # needs apps + dockutil from homebrew.sh

echo
echo "Bootstrap complete — run 'exec zsh' to load the new shell."
