#!/usr/bin/env bats
load test_helper

setup(){
  loadlib setexec throw sanitize
  callstack(){ stubfunc; }
}

@test "正常系: 実行コマンド設定" {
  run setexec abc
  test "$status" -eq 0
}

@test "異常系: 不正文字検出" {
  run setexec itis\;exec\ shellcode
  test "$status" -eq 1
}

@test "異常系: 引数不足" {
  run setexec 
  test "$status" -eq 1
}
