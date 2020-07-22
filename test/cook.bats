#!/usr/bin/env bats

load test_helper

setup(){
  DUMMYFUNC_PATH=$PWD/test/bundle/bin
  DUMMYOUT_DIR=$PWD/test/.tmp
  PATH=$DUMMYFUNC_PATH:$PWD/bin:$PATH

  mkdir -vp $DUMMYFUNC_PATH

  echo "dummycom(){ execute(){ echo 1 | tee -a $DUMMYOUT_DIR/out; }; argcheck(){ test \$# -ne 0 || exit 1;}; argcheck \$@; }" > $DUMMYFUNC_PATH/dummycom
  echo "name_tester(){ execute(){ echo $this; }; }" > $DUMMYFUNC_PATH/name_tester
  echo "id_tester(){ execute(){ echo $this_id; }; }" > $DUMMYFUNC_PATH/id_tester
  noncookedfuncdummy(){ test $# -eq 0 && setexec return 0 || return 1;}
  chmod +x $DUMMYFUNC_PATH/*

  mkdir -vp $DUMMYOUT_DIR
}

teardown(){
  rm -rv $DUMMYFUNC_PATH 
  rm -r $DUMMYOUT_DIR
}

@test "VALID: shelib function is inside a command in PATH" {
  setstub_parsers
  run cook dummycom a b c
  test "$status" -eq 0
  test -f $DUMMYOUT_DIR/out
}

@test "VALID: do not call callstack() when shelib_uncook=1" {
  export shelib_uncook=1
  run cook dummycom a b c
  test "$status" -eq 0
  test ! -f $DUMMYOUT_DIR/out
}

@test "INVALID: argument not specified" {
  setstub_parsers;
  run cook
  test "$status" -ne 0
}

@test "INVALID: argument is NOT exist in PATH" {
  setstub_parsers;
  run ./bin/cook noncookedfuncdummy 
  test "$status" -eq 1
}

@test "INVALID: argument is NOT exist" {
  setstub_parsers;
  run ./bin/cook notexistfuncdummy
  test "$status" -eq 1
}

