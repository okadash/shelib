#!/bin/sh -e
# shelib installer script

askyn(){
  echo -n  $@\  ;
  while read key; do 
    echo -n  $@\  ;
    test ! -z "$key" && {
      test ${key} = "y" && return 0;
      test ${key} = "n" && return 1;
    }
  done 
}
shelib_copysrc(){
  test $# -eq 2 || { echo invalid argument, abort ; exit 1 ; }
  if test -d $2 || test -f $2 ; then 
    askyn $2: already exist, overwrite? \[y/n\] && {
      rm -rv $2
      cp -av $1 $2
    } || { 
      echo not installed.;
      return 1;
    }
  else
    cp -av $1 $2
  fi
}

: ${SHELIB_ROOT:=$HOME/.shelib}
: ${SHELIB:=$SHELIB_ROOT/lib}
: ${SHELIB_EXEC:=$SHELIB_ROOT/bin}


test -d $SHELIB_ROOT || mkdir -v $SHELIB_ROOT
test -d $SHELIB || mkdir -vp $SHELIB
test -d $SHELIB_EXEC || mkdir -vp $SHELIB_EXEC

shelib_copysrc lib/core $SHELIB/core
for i in ./bin/* ; do 
  shelib_copysrc $i $SHELIB_ROOT/$i
done

if echo $PATH | grep -E :\?$HOME/.shelib/bin:\? > /dev/null; then
  :;
else
  case $SHELL in 
    */bash) echo PATH=$HOME/.shelib/bin:$PATH >> $HOME/.bashrc ;;
    *) echo PATH=$HOME/.shelib/bin:$PATH >> $HOME/.shrc ;;
  esac
fi

echo installed.; exit;
