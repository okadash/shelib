#!/usr/bin/env bats
load test_helper

setup(){
  loadlib setexec throw sanitize
  callstack(){ stubfunc; }
}

@test "VALID: execution command line was set" {
  run setexec abc
  test "$status" -eq 0
}

@test "INVALID:command line sanitized " {
  run setexec itis\;exec\ shellcode
  test "$status" -eq 1
}

@test "INVALID: argument not specified" {
  run setexec 
  test "$status" -eq 1
}
