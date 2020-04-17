#!/usr/bin/env bats
load test_helper

setup(){
  loadlib shiftstack chk throw
  callstack(){ stubfunc; }
}

@test "正常系 引数1削除" {
  run shiftstack 1 a b c d e
  test "$status" -eq 0
}

@test "正常系 引数全削除" {
  run shiftstack 5 a b c d e
  test "$status" -eq 0
}

@test "正常系 引数削除数 0" {
  run shiftstack 0 a
  test "$status" -eq 0
}

@test "np正常系 引数=0" {
  run shiftstack 0 a
  test "$status" -eq 0
}

@test "np異常系 引数が未指定" {
  run shiftstack
  test "$status" -eq 1
}

@test "np異常系 引数が負" {
  run shiftstack -5 a
  test "$status" -eq 1
}

