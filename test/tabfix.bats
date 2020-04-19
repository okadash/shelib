#!/usr/bin/env bats

load test_helper

setup(){
  loadlib tabfix
  showsample(){ 
    cat test/bundle/tabsample/$1 || { echo invalid sample ; exit 1;}
  }
}

@test "success with stdin" {
  showsample 1 | tabfix
}
@test "stdout has space-prepended lines" {
  showsample 1 | tabfix | grep -E "^[[:space:]]+.+"
}
@test "stdout has no space lines with no space included input" {
  showsample 2 | tabfix | grep -E "^[[:space:]]+.+" && return 1 || return 0
}
@test "stdout only has spaced lines with space-prepended line input" {
  showsample 3 | tabfix | grep -E "^[[:space:]]+.+" 
  showsample 3 | tabfix | grep -vE "^[[:space:]]+.+" && return 1 || return 0
}
