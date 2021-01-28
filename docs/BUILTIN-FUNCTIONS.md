shelib core library (lib/core) includes shelib builtin functions to be loaded from `cook`. Shelib functions mainly written to use functions below:

| name | description |
| --- | --- |
| `require` | check or load dependency for the shelib function |
| `throw` | throw exception and exit with status 1 |
| `chk` | validate the type of the argument |
| `sanitize` | sanitize arguments for invalid command line |
| `shiftstack` | call shelib pre-defined loop agian |
| `setexec` | set execute command for shelib callstack |
| `silent` | suppress command output and return status |
| `askyn` | ask y/n and return 0 or 1 |
| `showhelp` | show help for the shelib function |
| `this` | object internal referencing (experimental) |

