#!/bin/sh -ev
# test script for shelib

test -d bats-core-1.1.0/bin && PATH=$PWD/bats-core-1.1.0/bin:$PATH

# travis mode (avoid test failure in tests with PATH modification)
test "$1" = "--travis" && for i in test/*.bats; do 
  test $i = test/cook.bats \
    || test $i = test/showhelp.bats \
    || test $i = test/chk.bats \
    || bats $i; done

# test for localhost
test "$1" = "--travis" || bats test
