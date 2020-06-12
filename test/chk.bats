#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk throw sanitize
}

@test "VALID, -e: argument exists" {
  run chk -e "兎"
  test "$status" -eq 0
  test -z "$output"
}

@test "VALID, w/o option: argument exists" {
  run chk "梅"
  test "$status" -eq 0
  test -z "$output"
}

@test "INVALID -e: blank argument" {
  run chk -e ""
  test "$status" -eq 1
  test "$output" = "no argument, abort!"
}

@test "INVALID, w/o option: blank argument" {
  run chk -e ""
  test "$status" -eq 1
  test "$output" = "no argument, abort!"
}

@test "INVALID -e: argument not specified" {
  run chk -e 
  test "$status" -eq 1
  test "$output" = "no argument, abort!"
}

@test "VALID -v: variable declared" {
  it=is
  run chk -v it
  test "$status" -eq 0
}

@test "INVALID -v: variable not declared" {
  that=
  run chk -v that
  test "$status" -eq 1
}

@test "VALID -n: argument is unsigned integer" {
  run chk -n 15
  test "$status" -eq 0
}

@test "VALID -n: argument is ZERO" {
  run chk -n 0
  test "$status" -eq 0
}

@test "VALID -n archtecture-dependent: argument is a big integer" {
  run chk -n 928381752187239182
  test "$status" -eq 0
}

@test "INVALID -n archtecture-dependent: argument is a too big integer" {
  run chk -n 928381752187239182182938
  test "$status" -eq 1
}

@test "INVALID -n: argument is a negative integer" {
  run chk -n -10
  test "$status" -eq 1
}

@test "INVALID -n: argument is a float" {
  run chk -n 3.14
  test "$status" -eq 1
}

@test "INVALID -n: argument is a string" {
  run chk -n "horsenose"
  test "$status" -eq 1
}

@test "INVALID -n: argument not specified" {
  run chk -n 
  test "$status" -eq 1
}

@test "VALID -f: file exists" {
  touch .testing_compound
  run chk -f .testing_compound
  test "$status" -eq 0
  rm .testing_compound
}

@test "INVALID -f: file not exist" {
  run chk -f .nontesting_compound
  test "$status" -eq 1
}

@test "VALID -x: executable exist in PATH" {
  run chk -x sh
  test "$status" -eq 0
}

@test "VALID -x: executable not exist in PATH" {
  run chk -x doit_doish_nekoneko-earthlove
  test "$status" -eq 1
}
