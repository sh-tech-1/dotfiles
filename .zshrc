typeset -U path PATH
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
	$path
)

if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
	[[ -x /usr/local/bin/brew ]] && alias brew="arch -arch x86_64 /usr/local/bin/brew"
	alias x64='exec arch -x86_64 /bin/zsh'
	alias a64='exec arch -arm64e /bin/zsh'
	switch-arch() {
		if  [[ "$(uname -m)" == arm64 ]]; then
			arch=x86_64
		elif [[ "$(uname -m)" == x86_64 ]]; then
			arch=arm64e
		fi
		exec arch -arch $arch /bin/zsh
	}
fi

setopt magic_equal_subst

PROMPT="%n@%m(`uname -m`) %1~ $ "

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

source $HOME/scripts/exports.zsh
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
export OPENSSH="/usr/local/opt/openssh"



source $HOME/scripts/initialize.zsh
