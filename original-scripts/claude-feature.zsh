claude-feature() {
  local branch="$1"

  if [ -z "$branch" ]; then
    echo "Usage: claude-feature <feature-name>"
    return 1
  fi

  local current_branch
  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ "$current_branch" = "main" ] || [ "$current_branch" = "master" ]; then
    echo "Creating worktree from $current_branch branch..."
  else
    echo "Warning: current branch is '$current_branch', not main/master."
    echo "Worktree will be based on the current branch."
  fi

  local repo_name
  repo_name=$(basename "$(git rev-parse --show-toplevel)")
  local worktree_dir="../git-worktree/$repo_name/$branch"

  mkdir -p "../git-worktree/$repo_name"
  git worktree add "$worktree_dir" -b "$branch"
  cd "$worktree_dir" || return 1

  exec claude --permission-mode plan
}
