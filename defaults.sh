#!/bin/bash

printf "System - Disable software updates\n"
sudo softwareupdate --schedule off

printf "Finder - Show filename extensions\n"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

printf "Finder - Show path bar\n"
defaults write com.apple.finder ShowPathbar -bool true

printf "Finder - Show status bar\n"
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder

printf "delete Japanese file name of screen shot\n"
defaults write com.apple.screencapture name ""

printf "Don't make .DS_Store on network volume\n"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

printf "Continious key press\n"
defaults write -g ApplePressAndHoldEnabled -bool false # mac
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false # VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabljed -bool false # VS Code Insiders
# Reference: https://marketplace.visualstudio.com/items?itemName=vscodevim.vim
# Reference: https://discussionsjapan.apple.com/thread/10158407

printf "Keyboard - Fast key repeat (lower = faster; takes effect after re-login)\n"
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 5

printf "Keyboard - Disable text substitutions (better for coding / terminal)\n"
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

printf "Mouse - Tracking speed (higher = faster; range ~0-3, -1 disables accel)\n"
defaults write -g com.apple.mouse.scaling -float 3.0
# Takes effect after logout/login. Trackpad equivalent: com.apple.trackpad.scaling

# --- Keyboard shortcuts (com.apple.symbolichotkeys) --------------------------
# Hotkey IDs are fixed by macOS. parameters = (ASCII, key code, modifier mask).
# Modifier masks: Ctrl=262144  Opt=524288  Cmd=1048576  Shift=131072
# Space key: ASCII=32, key code=49.

printf "Shortcuts - Free Cmd+Space for Alfred (disable Spotlight)\n"
# ID 64 = Spotlight search (Cmd+Space)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; }"
# ID 65 = Finder search window (Opt+Cmd+Space) — uncomment to free it too:
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; }"

# Input source switching is handled by Karabiner-Elements, not symbolichotkeys:
#   Left Command  -> 英数 (Eisuu)
#   Right Command -> かな (Kana)
# See karabiner/karabiner.json (symlinked by setup.sh). The macOS Ctrl+Space
# input-source hotkeys (IDs 60/61) are intentionally left at their defaults.

# Apply symbolichotkeys changes without a full logout
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true