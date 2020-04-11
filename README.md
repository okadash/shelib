# What is it
Shelib , the shell scripting library, aims to be a convienient, extensible and modular library for /bin/sh and other shells on Unix-like systems. Load it for your scripts and make more simple, readable, maintainable and well-documented shell scripts and shell functions. bash, dash and their sh mode are officially supported and ksh is minor supported. Other shells are not tested but welcome to try to run it.

# FEATURES
* shelib has *builtin functions* and function initiator *cook() function* .  Any user can sideload all shelib builtin function with cooking your shell function like this:
```
cook yourfunction $@
```
* That's all to do, needed to load shelib builtin functions for yourfunction. You can use shelib builtins aroud the cooked function.
## shelb function
* *A function, which can be invoked only from cook() function, hereby called shelib function* (not a shelib builtin function). By default, cook() function can only execute a function at the time when called function name matches the name of executable. 
* Now we support 10 shelib builtins: *cook* *silent* *callstack* *rmarg* *throw* *sanitize* *setvar* *require* *set_exec* *chk*
* *cook* set a shelib callstack for the shelib function specified as an argument. shelib callstack invokes reserved loop functions *parseopts/parseargs*. If any of them exist, cook immediately invokes them and helps your option/argument parsing.
* Reserved initializers *loadenv*/*loadmod* are invoked before any loop functions. You can declare these functions to define environment variables and loadable shelib packages, inside your shelib functions.

# INSTALL

run ./install.sh

#TODO
Too many...
