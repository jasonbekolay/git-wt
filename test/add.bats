#!/usr/bin/env bats

load test_helper/setup

@test "add creates a new worktree for a new branch" {
    create_test_repo
    cd "$MAIN_WORKTREE"

    "$GIT_WT" add test-branch </dev/null &
    BGPID=$!
    sleep 2
    kill $BGPID 2>/dev/null || true
    wait $BGPID 2>/dev/null || true

    [ -d "$CONTAINER_DIR/test-branch" ]
    cd "$CONTAINER_DIR/test-branch"
    [ "$(git rev-parse --abbrev-ref HEAD)" = "test-branch" ]
}

@test "add checks out existing branch if it exists" {
    create_test_repo
    cd "$MAIN_WORKTREE"
    git branch existing-branch

    "$GIT_WT" add existing-branch </dev/null &
    BGPID=$!
    sleep 2
    kill $BGPID 2>/dev/null || true
    wait $BGPID 2>/dev/null || true

    [ -d "$CONTAINER_DIR/existing-branch" ]
    cd "$CONTAINER_DIR/existing-branch"
    [ "$(git rev-parse --abbrev-ref HEAD)" = "existing-branch" ]
}

@test "add converts slashes in branch name to dashes for directory" {
    create_test_repo
    cd "$MAIN_WORKTREE"

    "$GIT_WT" add feature/my-thing </dev/null &
    BGPID=$!
    sleep 2
    kill $BGPID 2>/dev/null || true
    wait $BGPID 2>/dev/null || true

    [ -d "$CONTAINER_DIR/feature-my-thing" ]
}

@test "add errors when no name provided" {
    create_test_repo
    cd "$MAIN_WORKTREE"

    run "$GIT_WT" add
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error" ]]
}
