#!/usr/bin/env bats

load test_helper

setup(){
  loadlib setvar sanitize throw
}

@test "VALID: assignment succeeded" {
  run setvar hoge neko
  test "$status" -eq 0
}

@test "VALID: blank assignment" {
  run setvar hoge ""
  test "$status" -eq 0
}

@test "INVALID: too few argument" {
  run setvar hoge 
  test "$status" -eq 1
}

@test "INVALID: too much argument" {
  run setvar hoge fuga neko
  test "$status" -eq 1
}

@test "INVALID: argument sanitized" {
  run setvar hoge "; sh -c \"exec shellcode\";"
  test "$status" -eq 1
}
