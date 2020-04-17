#!/usr/bin/env bats

load test_helper

setup(){
  loadlib silent
}

@test "正常系 標準出力しない" {
  run silent echo いついかなる時も正常終了する関数である
  test "$status" -eq 0
  test -z "$output"
}

@test "正常系 標準エラー出力しない" {
  run silent cat .nontesting_compound
  test "$status" -eq 1
  test -z "$output"
}

@test "異常系 引数が未指定" {
  run silent 
  test "$status" -eq 1
}
