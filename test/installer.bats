#!/usr/bin/env bats

load test_helper

setup(){
  . bundle/installer
  export SHELIB_ROOT=$PWD/.test_shelibroot
}

teardown(){
  test -d $PWD/.test_shelibroot && rm -r $PWD/.test_shelibroot 
  return 0
}

@test "envinit UT: success with no arguments" {
  envinit; run envinit;
  test "$SHELIB_ROOT" = "$PWD/.test_shelibroot"
  valid; nomsg;
}

@test "envinit UT: SHELIB_ROOT insertion" {
  SHELIB_ROOT=$PWD/lib
  envinit
  test "$SHELIB_ROOT" = "$PWD/lib"
}

@test "check_opt UT: success with no arguments" {
  run check_opt; 
  valid; nomsg;
}

@test "check_opt UT: -f" {
  check_opt -f; run check_opt -f
  valid; nomsg;
  test "$FORCED_INSTALL" -eq 1
  test -z "$VERBOSE_OPTION"
}

@test "check_opt UT: -v" {
  check_opt -v; run check_opt -v
  valid; nomsg;
  test -z "$FORCED_INSTALL"
  test "$VERBOSE_OPTION" = "-v"
}

@test "check_opt UT: -f -v" {
  check_opt -f -v; run check_opt -f -v
  valid; nomsg;
  test $FORCED_INSTALL -eq 1
  test "$VERBOSE_OPTION" = "-v"
}
# check_opt -v -f : buggy option, not fixed

@test "install_shelibdir XT: create new SHELIB_ROOT/DIR/EXEC" {
  envinit; run init_shelibdir;
  valid; visiblemsg;
  test -d "$SHELIB_ROOT"
  test -d "$SHELIB"
  test -d "$SHELIB_EXEC"
}

@test "install_shelib_files XT: install files into new SHELIB_ROOT" {
  envinit; init_shelibdir;
  run install_shelib_files
  valid; nomsg;
  test -d $SHELIB/core/
  test -f $SHELIB/core/chk
  test -f $SHELIB_EXEC/cook
}
