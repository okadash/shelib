#!/usr/bin/env bats

load test_helper

setup(){
  DUMMYFUNC_PATH=$PWD/test/bundle/cookedcommanddummy
  DUMMYOUT_DIR=$PWD/test/.tmp
  PATH=$PWD/test/bundle:$PWD/bin:$PATH

  echo "cookedcommanddummy(){ execute(){ echo 1 | tee -a $DUMMYOUT_DIR/out; }; argcheck(){ test \$# -ne 0 || exit 1;}; argcheck \$@; }" > $DUMMYFUNC_PATH
  noncookedfuncdummy(){ test $# -eq 0 && setexec return 0 || return 1;}
  chmod +x $DUMMYFUNC_PATH

  mkdir -vp $DUMMYOUT_DIR
}

teardown(){
  rm $DUMMYFUNC_PATH
  rm -r $DUMMYOUT_DIR
}

@test "VALID: shelib function is inside a command in PATH" {
  setstub_parsers
  . $DUMMYFUNC_PATH
  run cook cookedcommanddummy a b c
  test "$status" -eq 0
  test -f $DUMMYOUT_DIR/out
}

@test "VALID: do not call callstack() when shelib_uncook=1" {
  export shelib_uncook=1
  run cook cookedcommanddummy a b c
  test "$status" -eq 0
  test ! -f $DUMMYOUT_DIR/out
}

@test "INVALID: argument not specified" {
  setstub_parsers;
  run cook
  test "$status" -eq 1
}

@test "INVALID: argument is NOT exist in PATH" {
  setstub_parsers;
  run ./bin/cook noncookedfuncdummy a b c
  test "$status" -eq 1
}

@test "INVALID: argument is NOT exist" {
  setstub_parsers;
  run ./bin/cook notexistfuncdummy a b c
  test "$status" -eq 1
}
