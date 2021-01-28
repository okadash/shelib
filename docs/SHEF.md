# About

Shef is the package manager for [shelib](https://github.com/okadash/shelib) functions. Any function can be downloaded and installed under ~/.shef.

# Usage

| commands | description |
| --- | --- |
| `shef install @pkg` | install shef packages from manifest repository |
| `shef install https://example.org/path/to/git/repo.git` | install shef packages with URL |
| `shef list` | list installed shef packages |
| `shef info pkgname` | show package manifest |
| `shef search <atom>` | show packages registered in shefdb. |
| `shef remove pkgname` | not implemented now |

# Requirement

* `git` needed to download (clone) shelib modules repository
* bash, dash, ksh or busybox sh. Unix-like systems recommended.

# Third party support

`shef` is designed to support shelib functions and third party with shelib-compatible directory structure.
git repository with following condition can be installed with `shef install` command:

* repository root has /bin or /lib directory 
* /lib directory can contain shell functions or other script that has no side effect to shelib callstack.
* /bin directory can contain any type of executables.

# Install

run [install.sh](https://github.com/okadash/shelib/blob/master/install.sh) for shelib.
