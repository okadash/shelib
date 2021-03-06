**@core** --- the shell scripting library  

# ATTENTION

Shelib is now under the maintainance mode. We do not ship any additional features and bugfixes without any requests from active users.

# About

Shelib , the shell scripting library, aims to be a convienient, extensible and modular library for /bin/sh and other shells on Unix-like systems. Load it for your scripts and make more simple, readable, maintainable and well-documented shell scripts and shell functions. 

sh modes on bash, dash and busybox sh are officially supported and ksh and mksh is minor supported. Other shells are not tested but welcomed to hack.

# Quick start
shelib has several *builtin functions* and their initiator script `cook` .  Any user can sideload all shelib builtin function with cooking your shell function like this:
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
git clone https://github.com/shimmortal/shelib shelib
cd shelib
./install.sh
```

# Usage sample

[@shimmortal/nik](https://github.com/shimmortal/nik) note taking wrapper script for vimmers

[@shimmortal/cosh](https://github.com/shimmortal/cosh) container shell toolkit for docker/lxc/lxd

[@shimmortal/indigo](https://github.com/shimmortal/indigo) Indigo API cli tool

# Features

shelib is designed to reduce loop declarations, unify argument parsing mechanisms and enable object-oriented coding style in shell script. 

* `cook` initiate shelib callstack for the cooked function (hereby called **shelib function**) and `callstack` function is immediately invoked after the cook execution.
* `callstack()` function invokes reserved parsers **parseopts** and **parseargs** and if you declare these reserved parser functions inside the shelib function, each of them is invoked in this order. At last, it runs **execute**.
* If you invoke `stackshift`, next callstack automatically executed for further argument parsing. But if not, shelib function will immiediatly terminate with `execute` function.

For more details, see [this](https://github.com/shimmortal/shelib/blob/master/docs/CALLSTACK-COMPONENTS.md).

# Shelib packages

You can write own shelib funcitons and distribute them as **shelib packages**. There are no coding standard and no centralized CVS for shelib packages. Just use git repository to share your shelib packages. 

See also [this document](https://github.com/shimmortal/shelib/blob/master/docs/SHEF.md) for shelib package manegement.

# Author

Okadarian Saru <okadas[at]tanban.org>

# Maintainer

Suzume Nomura <suzume315[at]g00.g1e.org>
