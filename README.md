# ABOUT
Shelib , the shell scripting library, aims to be a convienient, extensible and modular library for /bin/sh and other shells on Unix-like systems. Load it for your scripts and make more simple, readable, maintainable and well-documented shell scripts and shell functions. bash, dash and their sh modes are officially supported and ksh is minor supported. Other shells are not tested but welcome to try to run it.

# FEATURES
* shelib has *builtin functions* and initiator script *cook* .  Any user can sideload all shelib builtin function with cooking your shell function like this:
```
#!/bin/sh

...
yourfunction(){ something_here ; }
...

cook yourfunction $@
```
* That's all to do, needed to load shelib builtin functions for yourfunction. You can use shelib builtins inside the cooked function.

# INSTALL

```
cd this_repo_path
./install.sh
```

# INTERNAL

## shelib callstack
shelib is designed to reduce loop declarations, and to unify argument parsing mechanisms for shell functions.
*cook* sets shelib callstack for the cooked function (hereby called **shelib function**) and *callstack* function immediately invoked after the cook execution. 
*callstack()* function invokes reserved parsers *parsecmds*, *parseopts* and *parseargs* and if you declare these reserved parser functions inside the shelib function, each of them is invoked in the order and the new callstack loop is set to run *shiftstack()* with shift value and arguments $@. 
*shiftstack()* sets a new callstack for exist arguments $@ and make more one loop for given arguments with shift value. (so two arguments needed)
If no *shiftstack()* runs, all parser and *execute()* simply invoked, and exit.
All shelib function is style-free as like as generic shell functions and any constraints can be freely described in shelib functions in your order, with or without usage of shelib builtin functions.

## shelib global component
These functions are reserved inside *cook*. If exist, they are invoked at one time for the shelib function
* loadenv: fair to declare environmental variables for shelib funcitons 
* loadmod: fair to load external shell scripts or shell functions

## callstack component
These functions are reserved inside *callstack()*. If exist, they are invoked at several times with *shiftstack()*. (invoked at one time without *shiftstack()*)
* parsecmds: subcommand parser, fair to describe *if* or *case* syntax for your subcommand definition
* parseopts: option parser
* parseargs: argument parser
* execute: execution stack. if exist, run it at last of the callstack. If there are any command insersion by *setexec()*, the set command runs after *execute*.

## shelib builtin functions
* shelib core library (lib/core) includes shelib builtin functions to be loaded from *cook*
* Now we support 12 shelib builtins: *callstack*, *shiftstack*, *throw*, *silent*, *askyn*, *sanitize*, *setvar*, *require*, *set_exec*, *showhelp*, *tabfix* and *chk*

# TODO
* add comments for *require()* conditions
* a
* Too many...
