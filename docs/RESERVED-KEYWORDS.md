All builtin function is reserved keyword on shelib.
For other reserved keyword, see the section below.

## reserved variables and internal functions
* shelib uses 5 variables and 3 iterators internally. DO NOT use these variables in your functions:
  - shelib_askyn_resp
  - shelib_i
  - shelib_k
  - shelib_j
* `tabfix()` uses 3 internal description for word replacement. DO NOT use these names in your functions:
  - SHELIB_CHARDEL
  - SHELIB_TABADD
  - SHELIB_TABDEL
* require uses 4 internal volatile functions. DO NOT use/declare these functions in your functions, unless your functions will be overwritten:
  - shelib_chk_manifest
  - shelib_load_shpkg_content
  - shelib_load_shpkg_dir
  - unset_shelib_internal
* showhelp uses 10 internal volatile functions. DO NOT use/declare these functions in your functions, unless your functions will be overwritten:
  - shelib_chk_helpdoc_exist
  - shelib_set_help_header
  - shelib_get_help_header
  - shelib_show_usage
  - shelib_show_manifest
  - show_copyleft
  - showhelp_core
  - showhelp_detail
  - showhelp_inline
  - unset_shelib_internal
