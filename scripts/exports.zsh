export LANG=en_US.UTF-8
export DISABLE_AUTO_UPDATE=true

export ZSH="$HOME/.oh-my-zsh"

# --- PATH (brew dirs are already added by `brew shellenv` in .zshrc) ----------
path=(
	$HOME/bin(N-/)
	$HOME/original-scripts/bin(N-/)
	$HOME/.cargo/bin(N-/)
	$HOME/.composer/vendor/bin(N-/)
	$HOME/.go/bin(N-/)
	$path
)

# --- Go ----------------------------------------------------------------------
export GOPATH=$HOME/.go
export GO111MODULE=on

# --- google-cloud-sdk (Homebrew cask; loaded only when present) --------------
gcloud_sdk="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
[[ -f "$gcloud_sdk/path.zsh.inc" ]]       && source "$gcloud_sdk/path.zsh.inc"
[[ -f "$gcloud_sdk/completion.zsh.inc" ]] && source "$gcloud_sdk/completion.zsh.inc"
unset gcloud_sdk

# --- enhancd -----------------------------------------------------------------
export ENHANCD_FILTER="fzf --reverse --ansi"
export ENHANCD_DISABLE_DOT=1

# --- misc --------------------------------------------------------------------
export TSC_WATCHFILE=UseFsEventsWithFallbackDynamicPolling
export DOCKER_CONTENT_TRUST=1
export OPENSSH="/opt/homebrew/opt/openssh"
