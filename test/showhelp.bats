#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk throw sanitize
  test -x test/bundle/dum2
  PATH=$PWD/test/bundle:$PATH
}

@test "VALID: return 0 for valid showhelp invokation" {
  run dum2 -h
  test "$status" -eq 0
}

@test "VALID: check help header \"usage: ...\"" {
  run :;
  # check for help header (shown)
  if dum2 -h | grep -iE \^Usage ; then :; else throw invalid header for shelibdoc ; fi
  test "$status" -eq 0
}

@test "VALID: check help body (shelibdoc) format" {
  run :;
  # check for help body (shown)
  if dum2 -h | grep -E "^[[:space:]]+(\[?(-+[[:alnum:]\*]+\|?)+\]? ?)+\t+[[:alnum:][:punct:][[:space:]]*"; then 
    echo [pass] generic shelibdoc style
  else throw invalid format for shelibdoc 
  fi
  test "$status" -eq 0
}

@test "VALID: check for short option (--short)" {
  run :;
  # check for help header (shown)
  if dum2 -h --short | grep -iE \^dum2 ; then :; else throw invalid header for shelibdoc ; fi
  # check for help body (not shown)
  if dum2 -h --short | grep -E "^[[:space:]]+(\[?(-+[[:alnum:]\*]+\|?)+\]? ?)+\t+[[:alnum:][:punct:][[:space:]]*"; then 
    throw invalid help format for --short option
  else echo [pass] generic shelibdoc style
  fi
  test "$status" -eq 0;
}
