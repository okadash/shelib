#!/usr/bin/env bats

load test_helper

setup(){
  SHELIB_DIR=$PWD/lib
  loadlib load_volatile sanitize
}

@test "VALID: argument sanitized" {
  run load_volatile "sh -c \"exec evil code\""
  test "$status" -eq 1
}

@test "VALID: load require_volatile" {
  load_volatile require 
  run type shelib_chk_manifest 
  test "$status" -eq 0
}

@test "INVALID: load unknown volatile" {
  run load_volatile notexistvol
  test "$status" -eq 1
}
