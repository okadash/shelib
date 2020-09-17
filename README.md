**@core** --- the shell scripting library  [![Build status](https://ci.appveyor.com/api/projects/status/noggl5ogly15wctq?svg=true)](https://ci.appveyor.com/project/okadasd/shelib) [![Build Status](https://travis-ci.org/okadash/shelib.svg?branch=dev)](https://travis-ci.org/okadash/shelib)

# About
Shelib , the shell scripting library, aims to be a convienient, extensible and modular library for /bin/sh and other shells on Unix-like systems. Load it for your scripts and make more **simple, readable, maintainable and well-documented** shell scripts and shell functions. sh modes on bash, dash and busybox sh are officially supported and ksh and mksh is minor supported. Other shells are not tested but welcomed to hack.

# Quick start
shelib has *builtin functions* and initiator script `cook` .  Any user can sideload all shelib builtin function with cooking your shell function like this:
```
#!/bin/sh

yourfunction(){
  something_here...
  ...
}

cook yourfunction $@
```
That's all to do, needed to load shelib builtin functions for *yourfunction*. You can use shelib builtins inside the cooked function. If you don't use any shelib builtins, the function will be simply invoked and exit. 

You can use *yourfunction* as a style-free generic shell function and any procedure can be freely written in shell script in your order, with or without usage of shelib builtin functions.

(There are some limitations to load shell scripting assets for cooked functions.)


# Install

```
git clone https://github.com/okadash/shelib shelib
cd shelib
./install.sh
```

# Usage sample

[@okadash/nik](https://github.com/okadash/nik) note taking wrapper script for vimmers

[@okadash/shef](https://github.com/okadash/shef) shelib function package manager

[@okadash/cosh](https://github.com/okadash/cosh) container shell toolkit for docker/lxc/lxd

[@okadash/indigo](https://github.com/okadash/indigo) Indigo API cli tool

# Features

shelib is designed to reduce loop declarations, unify argument parsing mechanisms and enable object-oriented coding style in shell script. 

* `cook` initiate shelib callstack for the cooked function (hereby called **shelib function**) and `callstack` function is immediately invoked after the cook execution.
* `callstack()` function invokes reserved parsers **parseopts** and **parseargs** and if you declare these reserved parser functions inside the shelib function, each of them is invoked in this order. At last, it runs **execute**.
* If you `shift` argument, next callstack automatically executed for further argument parsing but if not, shelib function will immiediatly terminate with `execute` function.

## shelib initiator
These functions are reserved inside `cook` script. If initiator functions below declared, they are invoked at once for the shelib function.

| name | description |
| --- | --- |
| `cook` | make a shell function to a **shelib function**, load shelib builtins for the first argument and invoke it |
| **loadmod** | load external shell scripts, shelib submodules and any type of dependencies for the shelib functions |
| **loadenv** | set global environmental variables. Global variable declaration is not recommended in shelib functions. use object referencing with `this` command. |

## callstack components
These functions are reserved inside `callstack()`. If callstack component functions are declared inside a shelib function, they are invoked at one or more times for the `cook` invokation.

| name | description |
| --- | --- |
| **parseopts** | parse options, invoked before **parseargs** |
| **parseargs** | parse arguments (also can parse --opt style option parsing) |
| **execute** | execution stack. If declared, run it at the termination of the callstack. If there are any command insersion by `setexec`, command set by `setexec()` runs after *execute*. |

## shelib builtin functions
shelib core library (lib/core) includes shelib builtin functions to be loaded from `cook`. Shelib functions mainly written to use functions below:

| name | description |
| --- | --- |
| `require` | load dependency |
| `throw` | throw exception and exit with status 1 |
| `chk` | validate the type of the argument |
| `sanitize` | sanitize arguments for invalid/malformed commandline argument |
| `shiftstack` | call shelib pre-defined loop agian |
| `setexec` | set execute command for shelib callstack |
| `silent` | suppress command output and return status |
| `askyn` | ask y/n and return 0 or 1 |
| `showhelp` | show help for the shelib function |
| `this` | object referencing command (experimental) |

For more details, see [this](https://github.com/okadash/shelib-v5/blob/master/INTERNAL.md).

# shelib packages

You can write own shelib funcitons and distribute them as **shelib packages**. There are no coding standard and no centralized CVS for shelib packages. Just use git repository to share your shelib packages. 

See also [@okadash/shef](https://github.com/okadash/shef) for shelib package manegement.

# Contact

shelib-support@lab.sysnk.net (SysNaka Lab.)
