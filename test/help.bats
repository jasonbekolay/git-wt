#!/usr/bin/env bats

load test_helper/setup

@test "version prints version string" {
    run "$GIT_WT" version
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^git-wt\ [0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "--version prints version string" {
    run "$GIT_WT" --version
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^git-wt\ [0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "help prints usage" {
    run "$GIT_WT" help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "git wt" ]]
    [[ "$output" =~ "Usage:" ]]
}

@test "--help prints usage" {
    run "$GIT_WT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}
