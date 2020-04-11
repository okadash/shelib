#!/usr/bin/env bats

load test_helper

setup(){
  loadlib setvar sanitize throw
}

@test "正常系: 代入成功" {
  run setvar hoge neko
  test "$status" -eq 0
}

@test "正常系: 空文字列の代入" {
  run setvar hoge ""
  test "$status" -eq 0
}

@test "異常系: 引数不足" {
  run setvar hoge 
  test "$status" -eq 1
}

@test "異常系: 引数過剰" {
  run setvar hoge fuga neko
  test "$status" -eq 1
}

@test "異常系: 不正文字の混入" {
  run setvar hoge "; sh -c \"exec shellcode\";"
  test "$status" -eq 1
}
