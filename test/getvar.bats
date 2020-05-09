#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk throw setvar getvar
}

@test "VALID: variable set" {
  ok=ok
  run getvar ok
  test "$status" -eq 0
}

@test "INVALID: variable not set" {
  ok=ok
  run getvar nok
  test "$status" -eq 1
}
