#!/usr/bin/env /bin/bash

loadlib_all(){
  for i in lib/core/*; do . $i; done
}

loadlib(){
  test -z $1 && { echo argument needed >&2; exit 1; }
  for i in $@; do
    test -f lib/core/$i && . lib/core/$i 
  done
}

#stub function for readability
stubfunc(){ :; }

setstub_parsers(){
  parseopts(){ opt=this; }
  parsecmds(){ cmd=that; }
  parseargs(){ arg=them; }
}

setstub_tester(){
  test $opt = this && test $cmd = that && $arg = them && return 0 || return 1
}

valid(){ test "$status" -eq 0 || return 1; }
invalid(){ test "$status" -eq 1 || return 1; }
visiblemsg(){ test ! -z "$output" && return 0 || return 1; }
nomsg(){ test -z "$output" || return 1; }

PATH=$PWD/bin:$PATH
