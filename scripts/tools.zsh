# Snapshot installed Homebrew FORMULAE into scripts/.brew_installed and commit.
# NOTE: scripts/.brew_cask_installed is a *curated* manifest (the desired app set
# consumed by homebrew.sh) and is intentionally NOT regenerated here, so running
# `mbi` never clobbers it.
make-brew-installed() {
  local dotfiles oldpwd snapshot
  dotfiles=$(cd "$(dirname "$(readlink "$HOME/scripts")")" && pwd) || return 1
  oldpwd=$(pwd)
  snapshot="$dotfiles/scripts/.brew_installed"
  brew list --formula >"$snapshot"
  cd "$dotfiles" || return 1
  \git add "$snapshot"
  \git commit -m "Update homebrew formulae snapshot"
  \git push origin "$(_get_default_branch)"
  cd "$oldpwd"
}

alias mbi='make-brew-installed'

login-docker-hub() {
  echo $GITHUB_TOKEN | docker login ghcr.io -u ${GITHUB_USER} --password-stdin
}

alias ldh='login-docker-hub'
