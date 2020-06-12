#!/usr/bin/env bats

load test_helper

setup(){
  loadlib throw
}

@test "VALID: make error and exit" {
  run throw this is a exception
  test "$status" -eq 1
  test "$output" = "this is a exception, abort!"
}
