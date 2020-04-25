#!/bin/sh -ev
# test script for shelib

test -d bats-core-1.1.0/bin && PATH=$PWD/bats-core-1.1.0/bin:$PATH

case $1 in 
  --travis|--appveyor) 
  ## automated mode (avoid test failure in tests with PATH modification)
    for i in test/*.bats; do 
    test $i = test/cook.bats \
      || test $i = test/showhelp.bats \
      || test $i = test/require.bats \
      || bats $i; done ;;
  *) 
  ## manual test for localhost
    bats test ;;
esac
