#!/usr/bin/env bats

load test_helper

setup(){
  loadlib require chk throw sanitize
  SHELIB_DIR=$PWD/lib
  export SHELIB_DIR
}

@test "VALID: load shelib module @core/chk" {
  run require @core/chk
  test "$status" -eq 0
}

@test "VALID: load all shelib module with @shpkg syntax" {
  run require @core
  require @core
  test "$status" -eq 0
  type callstack
}

@test "VALID: /path/to/script syntax" {
  run require $PWD/test/bundle/dum2func
  require $PWD/test/bundle/dum2func
  test "$status" -eq 0
  type dum2func
}

@test "VALID: executable exist in PATH" {
  run require grep
  test "$status" -eq 0
}

@test "INVALID: SHELIB_DIR not defined" {
  SHELIB_DIR=
  run require @core/chk
  test "$status" -eq 1
}

@test "INVALID: try to load core/notexist" {
  run require @core/notexist
  test "$status" -eq 1
}

@test "INVALID: try to load non-exist shelib module" {
  run require @therearenothing
  test "$status" -eq 1
}

@test "INVALID: executable not exist in PATH" {
  run require shelibexecnotexistinpath
  test "$status" -eq 1
}

