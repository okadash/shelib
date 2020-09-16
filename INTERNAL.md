
## shelib callstack
shelib is designed to reduce loop declarations, unify argument parsing mechanisms and object-oriented style coding on shell scripts.

*cook* sets shelib callstack for the cooked function (hereby called **shelib function**) and *callstack* function is immediately invoked after the cook execution.

*callstack()* function invokes reserved parsers *parsecmds*, *parseopts* and *parseargs* and if you declare these reserved parser functions inside the shelib function, each of them is invoked in the order and the new callstack loop is set to run *shiftstack()* with shift value and arguments $@.

*shiftstack()* sets a new callstack for arguments $@ and make additional loop for given arguments with shift value. (so two arguments needed)
If no *shiftstack()* runs, all parser and *execute()* simply invoked, and exit.
All shelib function is style-free as like as generic shell functions and any constraints can be freely described in shelib functions in your order, with or without usage of shelib builtin functions.

## reserved variables and internal functions
* shelib uses 5 variables and 3 iterators internally. DO NOT use these variables in your functions:
  - SHELIB_DIR
  - shelib_setdir_loaded
  - shelib_askyn_resp
  - shelib_i
  - shelib_k
  - shelib_j
* *tabfix()* uses 3 internal description for word replacement. DO NOT use these names in your functions:
  - SHELIB_CHARDEL
  - SHELIB_TABADD
  - SHELIB_TABDEL
* showhelp uses 9 internal functions. DO NOT use/declare these functions in your functions:
  - shelib_show_usage
  - shelib_show_manifest
  - chk_helpdoc_exist
  - showhelp_core
  - showhelp_detail
  - showhelp_inline
  - set_help_header
  - get_help_header
  - unset_internal

