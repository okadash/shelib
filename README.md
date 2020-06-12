**@shelib/core** --- the shell scripting library  [![Build status](https://ci.appveyor.com/api/projects/status/noggl5ogly15wctq?svg=true)](https://ci.appveyor.com/project/okadasd/shelib) [![Build Status](https://travis-ci.org/okadash/shelib.svg?branch=dev)](https://travis-ci.org/okadash/shelib)

# ABOUT
Shelib , the shell scripting library, aims to be a convienient, extensible and modular library for /bin/sh and other shells on Unix-like systems. Load it for your scripts and make more simple, readable, maintainable and well-documented shell scripts and shell functions. sh modes on bash, dash and busybox sh are officially supported and ksh and mksh is minor supported. Other shells are not tested but welcomed to hack.

# FEATURES
shelib has *builtin functions* and initiator script *cook* .  Any user can sideload all shelib builtin function with cooking your shell function like this:
```
#!/bin/sh

...
yourfunction(){ something_here ; }
...

cook yourfunction $@
```
That's all to do, needed to load shelib builtin functions for yourfunction. You can use shelib builtins inside the cooked function.

# INSTALL

```
cd this_repo_path
./install.sh
```

# INTERNAL

## shelib callstack
shelib is designed to reduce loop declarations, and to unify argument parsing mechanisms for shell functions.

*cook* sets shelib callstack for the cooked function (hereby called **shelib function**) and *callstack* function is immediately invoked after the cook execution.

*callstack()* function invokes reserved parsers *parsecmds*, *parseopts* and *parseargs* and if you declare these reserved parser functions inside the shelib function, each of them is invoked in the order and the new callstack loop is set to run *shiftstack()* with shift value and arguments $@.

*shiftstack()* sets a new callstack for arguments $@ and make additional loop for given arguments with shift value. (so two arguments needed)
If no *shiftstack()* runs, all parser and *execute()* simply invoked, and exit.
All shelib function is style-free as like as generic shell functions and any constraints can be freely described in shelib functions in your order, with or without usage of shelib builtin functions.

## shelib global components
These functions are reserved inside *cook*. If exist, they are invoked at one time for the shelib function
* loadenv: good to declare environmental variables for shelib funcitons
* loadmod: good to load external shell scripts or shell functions

## callstack components
These functions are reserved inside *callstack()*. If exist, they are invoked at several times with *shiftstack()*. If you don't invoke *shiftstack()* inside your shelib function, all callstack component will be simplly invoked at one time and exit.
* parsecmds: subcommand parser, good to describe *if* or *case* syntax for your subcommand definition
* parseopts: option parser
* parseargs: argument parser
* execute: execution stack. if exist, run it at the last of the callstack. If there are any command insersion by *setexec()*, set command runs after *execute*.

## shelib builtin functions
* shelib core library (lib/core) includes shelib builtin functions to be loaded from *cook*
* Now we support 14 shelib builtins:
 - *callstack*
 - *genseed*
 - *shiftstack*
 - *throw*
 - *silent*
 - *askyn*
 - *sanitize*
 - *setvar*
 - *getvar*
 - *require*
 - *setexec*
 - *showhelp*
 - *tabfix*
 - *chk*

## reserved variables and internal functions
* shelib uses 5 variables and 3 iterators internally. Not recommended to use these variables in your functions:
 - SHELIB_DIR
 - shelib_setdir_loaded
 - shelib_askyn_resp
 - shelib_i
 - shelib_k
 - shelib_j
* *tabfix()* uses 3 internal description for word replacement. Not recommended to use these names in your functions:
 - SHELIB_CHARDEL
 - SHELIB_TABADD
 - SHELIB_TABDEL
* showhelp uses 8 internal functions. Not recommended to use/declare these functions in your functions:
 - shelib_show_usage
 - shelib_show_manifest
 - chk_helpdoc_exist
 - showhelp_core
 - showhelp_detail
 - showhelp_inline
 - set_help_header unset_internal
 - get_help_header unset_internal

# TODO
* make usage documentation
