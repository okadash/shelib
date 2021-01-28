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