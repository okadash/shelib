#!/bin/sh -ev
# test script for shelib

test -d bats-core-1.1.0/bin && PATH=$PWD/bats-core-1.1.0/bin:$PATH

for i in test/*.bats; do bats $i; done
