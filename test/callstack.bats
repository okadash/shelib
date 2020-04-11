#!/usr/bin/env bats

load test_helper

setup(){
  loadlib callstack silent throw setexec sanitize
  setall_parser(){
    parseopts(){ opt=this; }
    parsecmds(){ cmd=that; }
    parseargs(){ arg=them; }
  }
}

@test "異常系 no parser and no execute()" {
  run callstack
  test "$status" -eq 1
  test ! -z "$output" 
}

@test "異常系 no execute() without exec_cmd" {
  setall_parser
  run callstack
  test "$status" -eq 1
}

@test "正常系 no parser" {
  execute(){ echo cute; }
  run callstack
  test "$status" -eq 0
  test "$output" = "cute"
}

@test "正常系 parsers and execute()" {
  setall_parser;
  execute(){ echo some $cmd $opt $arg; }
  run callstack
  test "$status" -eq 0
  test ! -z "$output"
  test "$output" = "some that this them"
}

@test "正常系:結合 parsers and setexec()" {
  setall_parser;
  setexec echo some that this them
  run callstack
  test "$status" -eq 0
  test ! -z "$output"
  test "$output" = "some that this them"
}


