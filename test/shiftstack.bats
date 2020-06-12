#!/usr/bin/env bats
load test_helper

setup(){
  loadlib shiftstack chk throw
  callstack(){ stubfunc; }
}

@test "VALID: an argument removed" {
  run shiftstack 1 a b c d e
  test "$status" -eq 0
}

@test "VALID: all argument removed" {
  run shiftstack 5 a b c d e
  test "$status" -eq 0
}

@test "VALID: no argument removed" {
  run shiftstack 0 a
  test "$status" -eq 0
}

@test "VALID: both arguments are 0" {
  run shiftstack 0 0
  test "$status" -eq 0
}

@test "INVALID: argument not specified" {
  run shiftstack
  test "$status" -eq 1
}

@test "INVALID: first argument is nagative value" {
  run shiftstack -5 a
  test "$status" -eq 1
}

