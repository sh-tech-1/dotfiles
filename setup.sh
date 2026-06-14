#!/usr/bin/env zsh
# ============================================================================
# setup.sh — idempotent dotfiles bootstrap (safe to re-run). Apple Silicon.
# Run AFTER Homebrew is installed; before/after homebrew.sh either order works.
# ============================================================================

DOTFILES="$HOME/dotfiles"
ZSH_DIR="$HOME/.oh-my-zsh"

echo "==> oh-my-zsh"
if [[ ! -d "$ZSH_DIR" ]]; then
	# RUNZSH=no     → don't exec a new shell (so this script keeps running)
	# KEEP_ZSHRC=yes → don't clobber the .zshrc we symlink below
	RUNZSH=no KEEP_ZSHRC=yes sh -c \
		"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Volta (node toolchain manager)"
[[ -d "$HOME/.volta" ]] || curl -fsSL https://get.volta.sh | bash -s -- --skip-setup

echo "==> directories"
mkdir -p "$HOME/.config/nvim/autoload" "$HOME/.ssh/sockets"
chmod 700 "$HOME/.ssh" "$HOME/.ssh/sockets"

echo "==> symlinks"
link() { ln -nsf "$1" "$2"; }
link "$DOTFILES/.zshrc"            "$HOME/.zshrc"
link "$DOTFILES/.procs.toml"       "$HOME/.procs.toml"
link "$DOTFILES/.fdignore"         "$HOME/.fdignore"
link "$DOTFILES/.tmux.conf"        "$HOME/.tmux.conf"
link "$DOTFILES/.vimrc"            "$HOME/.config/nvim/init.vim"
link "$DOTFILES/webpack.config.js" "$HOME/webpack.config.js"
link "$DOTFILES/scripts"           "$HOME/scripts"
link "$DOTFILES/original-scripts"  "$HOME/original-scripts"
link "$DOTFILES/.ssh/config"       "$HOME/.ssh/config"

# machine-specific overrides (tokens / secrets) — created empty, never committed
[[ -f "$HOME/.zshrc.local" ]] || touch "$HOME/.zshrc.local"

echo "==> zsh plugins"
clone() { [[ -d "$2" ]] || git clone --depth 1 "$1" "$2"; }
clone https://github.com/wfxr/forgit.git                      "$ZSH_DIR/plugins/forgit"
clone https://github.com/seebi/dircolors-solarized.git        "$ZSH_DIR/plugins/dircolors-solarized"
clone https://github.com/chitoku-k/fzf-zsh-completions.git    "$ZSH_DIR/plugins/fzf-zsh-completions"
clone https://github.com/b4b4r07/enhancd.git                  "$ZSH_DIR/plugins/enhancd"
clone https://github.com/zsh-users/zsh-autosuggestions.git    "$ZSH_DIR/plugins/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_DIR/plugins/zsh-syntax-highlighting"

echo "==> tmux plugin manager"
clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"

echo "==> vim-plug (nvim)"
[[ -f "$HOME/.config/nvim/autoload/plug.vim" ]] || \
	curl -fsSLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "==> fzf key-bindings"
if command -v fzf >/dev/null 2>&1; then
	"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish 2>/dev/null || true
fi

echo "==> macOS key-repeat"
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 5

echo "==> done. Run 'exec zsh' (or open a new terminal) to load the config."
