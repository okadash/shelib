#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk sanitize throw setvar getvar
  this_id=a7f83e628a
}

@test "VALID: variable set" {
  setvar ok ok
  run getvar ok
  test "$status" -eq 0
}

@test "INVALID: variable not set" {
  ok=ok
  run getvar ok
  test "$status" -eq 1
}

@test "INVALID: callstack identifier is corrupted" {
  setvar ok ok
  this_id=
  run getvar ok
  test "$status" -eq 1
}

@test "INVALID: variable not assigned to specified argument" {
  run getvar mok
  test "$status" -eq 1
}
