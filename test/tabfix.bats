#!/usr/bin/env bats

load test_helper

setup(){
  loadlib tabfix
  showsample(){ 
    cat test/templates/tabsample_$1 || { echo invalid sample ; exit 1;}
  }
}

@test "VALID: success with stdin" {
  showsample 1 | tabfix
}
@test "VALID: stdout has space-prepended lines" {
  showsample 1 | tabfix | grep -E "^[[:space:]]+.+"
}
@test "VALID: stdout has no space lines with no space included input" {
  showsample 2 | tabfix | grep -E "^[[:space:]]+.+" && return 1 || return 0
}
@test "VALID: stdout only has spaced lines with space-prepended line input" {
  showsample 3 | tabfix | grep -E "^[[:space:]]+.+" 
  showsample 3 | tabfix | grep -vE "^[[:space:]]+.+" && return 1 || return 0
}
