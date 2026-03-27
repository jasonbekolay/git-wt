_git_wt() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local subcommands="add remove clean list help version"

    if [ "$COMP_CWORD" -eq 2 ]; then
        # Complete subcommands and worktree names
        local worktrees
        worktrees=$(git worktree list --porcelain 2>/dev/null | grep '^worktree ' | sed 's/^worktree //' | xargs -I{} basename {})
        COMPREPLY=($(compgen -W "$subcommands $worktrees" -- "$cur"))
    fi
}

# Register for both git-wt and git wt
complete -F _git_wt git-wt
complete -F _git_wt git_wt

# Git subcommand completion (git wt <tab>)
__git_complete wt _git_wt 2>/dev/null || true
