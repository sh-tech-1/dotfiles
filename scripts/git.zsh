_GIT_DIFF_FILES=
_get_git_branch() {
  ref=$(\git symbolic-ref HEAD 2> /dev/null)
  echo "${ref#refs/heads/}"
}

_get_git_diff_files() {
  ref=$(_get_git_branch)
  if [[ $ref == 'master' ]]; then
    return 1
  fi
  _GIT_DIFF_FILES=$(\git diff --name-only --diff-filter=ACMR origin/master...HEAD)
  if [[ ! $? =~ ^(0|130)$ ]]; then
    return 1
  fi
  return 0
}

fzf-checkout-histories() {
  local branches result target current
  result=$(\git --no-pager reflog 2>/dev/null)
  current=${$(\git symbolic-ref HEAD 2> /dev/null)#refs/heads/}
  if [[ ! $? =~ ^(0|130)$ ]]; then
    return 1
  fi
  branches=$(
    echo "$result" |
    awk '$3 == "checkout:" && !a[$8]++ && NR>1 && $8 != "'"$current"'" && /moving from/ {print $8}'
  )
  target=$(
    echo $branches |
    awk '$0 ~ /./{print $0}' |
    fzf --prompt "HISTORY> "
  )
  \git checkout "$target"
}

fzf-checkout-files() {
  local target
  _get_git_diff_files
  if [[ $? == 1 ]]; then
    return 1
  fi
  target=$(echo "$_GIT_DIFF_FILES" | awk '$0 ~ /./{print $0}' | fzf --prompt "FILE HISTORY> ")
  \git checkout -- "$target"
}

fzf-reset-files() {
  local target
  _get_git_diff_files
  if [[ $? == 1 ]]; then
    return 1
  fi
  target=$(echo "$_GIT_DIFF_FILES" | awk '$0 ~ /./{print $0}' | fzf --prompt "FILE HISTORY> ")
  \git reset master -- "$target"
  \git checkout -- "$target"
}

GIT_LOGGED=0
enhanced-gitalias() {
  if [[ $1 == 'log' ]]; then
    if [[ $GIT_LOGGED == 0 ]]; then
      GIT_LOGGED=1
      glo
      GIT_LOGGED=0
      return
    fi
  fi
  if [[ $1 == 'checkout' ]]; then
    case "$2" in
      "-")
        fzf-checkout-histories
        return
      ;;
      "--")
        if [[ $3 == '' ]]; then
          fzf-checkout-files
          return
        fi
      ;;
    esac
  fi
  if [[ $1 == 'reset' ]] && [[ $2 == 'master' ]]; then
    case "$3" in
      "--")
        if [[ $4 == '' ]]; then
          fzf-reset-files
          return
        fi
      ;;
    esac
  fi

  # shellcheck disable=SC2068
  \git $@
}

alias git='enhanced-\gitalias'
