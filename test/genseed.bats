#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk throw genseed
}

@test "VALID: seed generated with 8bytes" {
  run genseed 8
  test "$status" -eq 0
  test "${#output}" -eq 8
}

@test "VALID: seed generated with 1bytes" {
  run genseed 1
  test "$status" -eq 0
  test "${#output}" -eq 1
}

@test "VALID: no seed generated with 0 byte" {
  run genseed 0
  test "$status" -eq 0
}

@test "VALID: argument not specified" {
  run genseed
  test "$status" -eq 0
  test "${#output}" -eq 8
}

@test "INVALID: argument is negative" {
  run genseed -1
  test "$status" -eq 1
}

@test "INVALID: argument is not an integer" {
  run genseed ¼¯
  test "$status" -ne 0
}
