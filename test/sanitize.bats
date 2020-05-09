#!/usr/bin/env bats

load test_helper

setup(){
  loadlib throw sanitize
}

@test "VALID: no malicious sequence" {
  run sanitize toxicOxidant.itis
  test "$status" -eq 0
}

@test "SANITIZED: semi-colon detected" {
  run sanitize echo "echo; exec shellcodesums;"
  test "$status" -eq 1
}

@test "SANITIZED: double quotes detected" {
  run sanitize \"shellcodes\"
  test "$status" -eq 1
}

@test "SANITIZED: quotes detected" {
  run sanitize \'shellcodes\'
  test "$status" -eq 1
}

@test "SANITIZED: bar detected" {
  run sanitize echo shellcodes \| sh
  test "$status" -eq 1
}

@test "SANITIZED: backquotes detected" {
  run sanitize \`echo shellcodes\`
  test "$status" -eq 1
}

@test "SANITIZED: redirect detected" {
  run sanitize "echo shellcodes >> criticalscript"
  test "$status" -eq 1
}

@test "SANITIZED: ampathand detected" {
  run sanitize "&"
  test "$status" -eq 1
}

@test "SANITIZED: dollar detected" {
  run sanitize "\$TOO_DANGEROUS_VAR"
  test "$status" -eq 1
}
