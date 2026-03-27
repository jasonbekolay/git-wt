#compdef git-wt

_git-wt() {
    local -a subcommands
    subcommands=(
        'add:Add a new worktree and switch to it'
        'remove:Remove an existing worktree'
        'clean:Remove merged/gone branch worktrees'
        'list:List all worktrees'
        'help:Show help message'
        'version:Show version'
    )

    if (( CURRENT == 2 )); then
        _describe 'subcommand' subcommands
        # Also complete worktree names for the default switch behavior
        local -a worktrees
        worktrees=(${(f)"$(git worktree list --porcelain 2>/dev/null | grep '^worktree ' | sed 's/^worktree //' | xargs -I{} basename {})"})
        _describe 'worktree' worktrees
    fi
}

# Also register as a git subcommand completion
_git-wt "$@"
