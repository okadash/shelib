#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk throw sanitize
  test -x test/bundle/dum2
  PATH=$PWD/test/bundle:$PATH
}

@test "return 0 for valid showhelp invokation" {
  run dum2 -h
  test "$status" -eq 0
}

@test "valid header \"usage: ...\" for shelib doc" {
  run :;
  if dum2 -h | grep -iE \^Usage ; then :; else throw invalid header for shelibdoc ; fi
  test "$status" -eq 0
}

@test "valid shelibdoc format" {
  run :;
  if dum2 -h | grep -E "^[[:space:]]+(\[?(-+[[:alnum:]\*]+\|?)+\]? ?)+\t+[[:alnum:][:punct:][[:space:]]*"; then 
    echo [pass] generic shelibdoc style
  else throw invalid format for shelibdoc 
  fi
  test "$status" -eq 0
}
