#!/usr/bin/env bats

load test_helper

setup(){
  loadlib chk throw sanitize
}

@test "-e 正常系 引数が存在" {
  run chk -e "兎"
  test "$status" -eq 0
  test -z "$output"
}

@test "オプションなし 正常系 引数が存在" {
  run chk "梅"
  test "$status" -eq 0
  test -z "$output"
}

@test "-e 異常系 引数が空" {
  run chk -e ""
  test "$status" -eq 1
  test "$output" = "no argument, abort!"
}

@test "オプションなし 異常系 引数が空" {
  run chk -e ""
  test "$status" -eq 1
  test "$output" = "no argument, abort!"
}

@test "-e 異常系 引数が未指定" {
  run chk -e 
  test "$status" -eq 1
  test "$output" = "no argument, abort!"
}

@test "-v 正常系 変数が定義済" {
  it=is
  run chk -v it
  test "$status" -eq 0
}

@test "-v 異常系 変数が未定義" {
  that=
  run chk -v that
  test "$status" -eq 1
}

@test "-n 正常系 引数が整数" {
  run chk -n 15
  test "$status" -eq 0
}

@test "-n 正常系 引数が0" {
  run chk -n 0
  test "$status" -eq 0
}

@test "-n アーキテクチャ依存: 正常系 引数が巨大な整数" {
  run chk -n 928381752187239182
  test "$status" -eq 0
}

@test "-n アーキテクチャ依存: 異常系 引数が巨大すぎる整数" {
  run chk -n 928381752187239182182938
  test "$status" -eq 1
}

@test "-n 異常系 引数が負の値" {
  run chk -n -10
  test "$status" -eq 1
}

@test "-n 異常系 引数が浮動小数点数" {
  run chk -n 3.14
  test "$status" -eq 1
}

@test "-n 異常系 引数が文字列" {
  run chk -n "馬脚"
  test "$status" -eq 1
}

@test "-n 異常系 引数が未指定" {
  run chk -n 
  test "$status" -eq 1
}

@test "-f 正常系 ファイルが存在" {
  touch .testing_compound
  run chk -f .testing_compound
  test "$status" -eq 0
  rm .testing_compound
}

@test "-f 異常系 ファイルが不在" {
  run chk -f .nontesting_compound
  test "$status" -eq 1
}

@test "-x 正常系 実行ファイルが存在" {
  run chk -x sh
  test "$status" -eq 0
}

@test "-x 異常系 実行ファイルが不在" {
  run chk -x doit_doish_nekoneko-earthlove
  test "$status" -eq 1
}
