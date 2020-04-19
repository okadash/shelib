#!/usr/bin/env bats

load test_helper

setup(){
  DUMMYFUNC_PATH=$PWD/test/bundle/cookedfuncdummy
  PATH=`dirname $DUMMYFUNC_PATH`:$PATH
  echo 'cookedfuncdummy(){ test $# -ne 0 && setexec return 0 || return 1;}' > $DUMMYFUNC_PATH
  noncookedfuncdummy(){ test $# -eq 0 && setexec echo 0 || return 1;}
  chmod +x $DUMMYFUNC_PATH
  set_loadenv(){ dummyenv=dummy; }
  set_loadmod(){ dummymod(){ :;} ; }
  create_tmpmod(){ mkdir $SHELIB_ROOT/lib/dummy echo 'dum(){ echo dumdum; }' > $SHELIB_ROOT/lib/dummy/dum
  }
}

teardown(){
  rm $DUMMYFUNC_PATH
}

@test "正常系: PATHに存在するshelib関数" {
  setstub_parsers;
  . $DUMMYFUNC_PATH
  run ./bin/cook cookedfuncdummy a b c
  test "$status" -eq 0
}

@test "正常系: PATHに存在しない関数のshelib stack を呼出" {
  setstub_parsers;
  run ./bin/cook -f noncookedfuncdummy a b c
  test "$status" -eq 2
}

@test "異常系: 引数未指定" {
  setstub_parsers;
  run ./bin/cook
  test "$status" -eq 1
}

@test "異常系: 引数はPATHに存在しない関数" {
  setstub_parsers;
  run ./bin/cook noncookedfuncdummy a b c
  test "$status" -eq 1
}

@test "異常系: 引数は存在しない関数" {
  setstub_parsers;
  run ./bin/cook notexistfuncdummy a b c
  test "$status" -eq 1
}
