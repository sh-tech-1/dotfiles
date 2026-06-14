# ============================================================================
# .zshrc — symlinked to ~/.zshrc by setup.sh  (Apple Silicon default)
# ============================================================================

# --- Re-exec natively if launched under Rosetta ------------------------------
if [[ "$(arch)" != arm64 ]]; then
	exec arch -arm64 /bin/zsh "$@"
fi

typeset -U path PATH

# --- Homebrew (Apple Silicon) ------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- Optional Intel / Rosetta helpers ----------------------------------------
# `brew` stays native (above). Use `ibrew` for an x86_64 Homebrew if installed.
[[ -x /usr/local/bin/brew ]] && alias ibrew="arch -arch x86_64 /usr/local/bin/brew"
alias x64='exec arch -x86_64 /bin/zsh'
alias a64='exec arch -arm64e /bin/zsh'

setopt magic_equal_subst

# --- Prompt ------------------------------------------------------------------
# path + git branch; user@host prepended only inside an SSH session; the final
# `$` is green on success / red on the previous command's failure.
setopt prompt_subst
autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%f'
add-zsh-hook precmd vcs_info

_ssh_tag=''
[[ -n "$SSH_CONNECTION" ]] && _ssh_tag='%F{yellow}%n@%m%f '

PROMPT='${_ssh_tag}%F{cyan}%~%f${vcs_info_msg_0_} %(?.%F{green}.%F{red})$%f '

# --- Node (Volta) ------------------------------------------------------------
export VOLTA_HOME="$HOME/.volta"
path=("$VOLTA_HOME/bin" $path)

# --- oh-my-zsh ---------------------------------------------------------------
source $HOME/scripts/exports.zsh            # sets $ZSH and base env
plugins=(
	git
	forgit
	enhancd
	fzf-zsh-completions
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

source $HOME/scripts/settings.zsh
source $HOME/scripts/errors.zsh

export LS_COLORS=${(pj;:;)$(< $HOME/scripts/.ls_colors)}
export EXA_COLORS=${(pj;:;)$(< $HOME/scripts/.exa_colors)}
source $HOME/scripts/zstyle.zsh

source $HOME/scripts/optimizer.zsh
source $HOME/scripts/highlight.zsh
source $HOME/scripts/tools.zsh

source $HOME/scripts/aliases.zsh
source $HOME/scripts/fzf.zsh
source $HOME/scripts/git.zsh
source $HOME/scripts/aws.zsh
source $HOME/original-scripts/claude-feature.zsh

# rust (cargo) — present only after a rustup install
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --- Local overrides (tokens, secrets, machine-specific config; untracked) ----
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# --- Syntax highlighting MUST be sourced last --------------------------------
for _zsh_hl in \
	$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
	[[ -f $_zsh_hl ]] && { source $_zsh_hl; break; }
done
unset _zsh_hl
