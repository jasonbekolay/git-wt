# Shared setup for all git-wt tests
#
# Provides:
#   GIT_WT     - path to the git-wt script under test
#   TEST_DIR   - temporary directory for this test (cleaned up automatically)
#
# Call create_test_repo to set up a bare repo with a main worktree and
# optionally additional worktrees. Sets:
#   BARE_REPO       - path to the bare repo
#   MAIN_WORKTREE   - path to the main worktree
#   CONTAINER_DIR   - parent directory containing all worktrees

GIT_WT="$BATS_TEST_DIRNAME/../git-wt"

setup() {
    TEST_DIR=$(mktemp -d "$BATS_TMPDIR/git-wt-test.XXXXXX")
    export HOME="$TEST_DIR/fakehome"
    mkdir -p "$HOME"

    # Minimal git config so commits work
    git config --global user.email "test@test.com"
    git config --global user.name "Test"
    git config --global init.defaultBranch main
}

teardown() {
    rm -rf "$TEST_DIR"
}

# Create a bare repo with a main worktree that has one commit.
# Usage: create_test_repo
create_test_repo() {
    BARE_REPO="$TEST_DIR/repo.git"
    CONTAINER_DIR="$TEST_DIR/worktrees"
    mkdir -p "$CONTAINER_DIR"

    git init --bare "$BARE_REPO"

    MAIN_WORKTREE="$CONTAINER_DIR/main"
    git -C "$BARE_REPO" worktree add "$MAIN_WORKTREE" -b main

    # Create an initial commit so branches work
    cd "$MAIN_WORKTREE"
    echo "initial" > README.md
    git add README.md
    git commit -m "Initial commit"
}

# Add a worktree with a branch. Creates a commit on the branch.
# Usage: add_test_worktree <branch-name>
add_test_worktree() {
    local branch="$1"
    local dir_name="${branch//\//-}"
    cd "$MAIN_WORKTREE"
    git worktree add "$CONTAINER_DIR/$dir_name" -b "$branch"
    cd "$CONTAINER_DIR/$dir_name"
    echo "$branch" > branch.txt
    git add branch.txt
    git commit -m "Commit on $branch"
}
