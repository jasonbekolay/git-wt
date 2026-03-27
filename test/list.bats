#!/usr/bin/env bats

load test_helper/setup

@test "list shows worktrees" {
    create_test_repo
    add_test_worktree "feature-one"
    cd "$MAIN_WORKTREE"

    run "$GIT_WT" list
    [ "$status" -eq 0 ]
    [[ "$output" =~ "main" ]]
    [[ "$output" =~ "feature-one" ]]
}

@test "list shows only main when no other worktrees" {
    create_test_repo
    cd "$MAIN_WORKTREE"

    run "$GIT_WT" list
    [ "$status" -eq 0 ]
    [[ "$output" =~ "main" ]]
}
