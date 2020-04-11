#!/usr/bin/env bats

load test_helper

setup(){
  loadlib throw sanitize
}

@test "正常系 不正なシーケンスなし" {
  run sanitize toxicOxidant.itis
  test "$status" -eq 0
}

@test "異常系 セミコロン検出" {
  run sanitize echo "echo; exec shellcodesums;"
  test "$status" -eq 1
}

@test "異常系 double quotes detected" {
  run sanitize \"shellcodes\"
  test "$status" -eq 1
}

@test "異常系 quotes detected" {
  run sanitize \'shellcodes\'
  test "$status" -eq 1
}

@test "異常系 bar detected" {
  run sanitize echo shellcodes \| sh
  test "$status" -eq 1
}

@test "異常系 backquotes detected" {
  run sanitize \`echo shellcodes\`
  test "$status" -eq 1
}

@test "異常系 redirect detected" {
  run sanitize "echo shellcodes >> criticalscript"
  test "$status" -eq 1
}

@test "異常系 ampathand detected" {
  run sanitize "&"
  test "$status" -eq 1
}

@test "異常系 dollar detected" {
  run sanitize "\$TOO_DANGEROUS_VAR"
  test "$status" -eq 1
}
