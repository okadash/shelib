#!/usr/bin/env bats

load test_helper

setup(){
  loadlib require chk throw sanitize
  SHELIB_DIR=$PWD/lib
  export SHELIB_DIR
}

@test "正常系: load shelib module @core/chk" {
  run require @core/chk
  test "$status" -eq 0
}

@test "正常系: load all shelib module from @shpkg" {
  run require @core
  require @core
  test "$status" -eq 0
  type callstack
}

@test "正常系: /path/to/script loading" {
  run require $PWD/test/bundle/dum2func
  require $PWD/test/bundle/dum2func
  test "$status" -eq 0
  type dum2func
}

@test "正常系: executable exist in PATH" {
  run require grep
  test "$status" -eq 0
}

@test "異常系: SHELIB_DIR not defined" {
  SHELIB_DIR=
  run require @core/chk
  test "$status" -eq 1
}

@test "異常系: try to load core/notexist" {
  run require @core/notexist
  test "$status" -eq 1
}

@test "異常系: try to load non-exist shelib module" {
  run require @therearenothing
  test "$status" -eq 1
}

@test "異常系: executable not exist in PATH" {
  run require shelibexecnotexistinpath
  test "$status" -eq 1
}

