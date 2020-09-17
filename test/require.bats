#!/usr/bin/env bats

load test_helper

make_echo_script(){
  echo -e \#!/bin/sh\\\nechok\(\)\{ echo ok\; \}\\\nechok > ${ECHO_SCRIPT_PATH:?ECHO_SCRIPT_PATH not set}
}
setup(){
  loadlib require chk throw sanitize load_volatile setvar getvar
  SHELIB_DIR=$PWD/lib
  ECHO_SCRIPT_PATH=$PWD/test/bundle/echok
  export SHELIB_DIR
  make_echo_script
  this_id=dummy_id_hoge
}
teardown(){
  rm -v $ECHO_SCRIPT_PATH
}

@test "VALID: load shelib module @core/chk" {
  run require @core/chk
  chk -e 1
  test "$status" -eq 0
}

@test "VALID: load all shelib module with @shpkg syntax" {
  run require @core
  require @core
  test "$status" -eq 0
  type callstack
}

@test "VALID: /path/to/script syntax" {
  run require $ECHO_SCRIPT_PATH
  require $ECHO_SCRIPT_PATH
  test "$status" -eq 0
  type echok
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

