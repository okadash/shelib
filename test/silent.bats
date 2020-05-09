#!/usr/bin/env bats

load test_helper

setup(){
  loadlib throw silent
}

@test "VALID: suppress stdout" {
  run silent echo fox dumping a virus
  test "$status" -eq 0
  test -z "$output"
}

@test "VALID: suppress stderr" {
  run silent cat .cat_all_over_the_world
  test "$status" -eq 1
  test -z "$output"
}

@test "INVALID: argument not specified" {
  run silent 
  test "$status" -eq 1
}
