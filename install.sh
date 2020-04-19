#!/bin/sh -e
# shelib installer script

test ! -d $PWD/bundle && { 
  echo bundle directory not exist. Are you in shelib src directory? >&2; 
  exit 1;
}

# load installer functions
. ./bundle/installer

envinit
check_opt $@
init_shelibdir
install_shelib_files 
install_loader_shrc

echo shelib installed.; exit;
