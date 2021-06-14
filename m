From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 14 Jun 2021 12:56:36 +0100
Subject: [LTP] [RFC PATCH v3 0/2] Libclang based analyzer
Message-ID: <20210614115638.25467-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This implements a TEST() macro check and integrates the check into the
build system.

Compared to the Coccinelle version this is verbose. I do not fancy
implementing auto fixes this way. I think it would be best to continue
using Coccinelle for that. The TEST fixes and semantic patches used to
create them are in a separate patch series.

However I think libclang will allow us to get all the low hanging
fruit without creating major problems for test
developers. Unfortunately libclang is difficult to use without
installing clang itself and llvm-config. However these are only
development dependencies and are not required for building.

I guess it could be run during CI if we either fix all the existing
TEST() usages in the library or add an ignore list. I already have a
Coccinelle script to help with the former.

TODO & Known issues:
* Solve/ignore missing header errors emitted by libclang
* Solve/ignore missing function errors emitted by libclang.
* Solve warning emitted by configure on Ubuntu because the preprocessor
  check can not find clang-c/Index.h (most likely CFLAGS related)
* Detect other cases where library functions set TST_RET and TST_ERR
* Create a script to check whether only symbols available in LLVM10 are
  used.

V3:
* Look for libclang and clang using autoconf
* Print warnings and installation instructions if 'make check' is run
  on a system where (lib)clang is missing. Note that we need libclang,
  clang and llvm-config. On most distros this probably requires installing
  clang-devel and llvm-devel which should install all required deps.
* Remove the functions which were not available in LLVM10
* Use -DLTPLIB instead of searching for 'struct tst_test test'

V2:
* Consistently use singular form of 'check'
* Include missing clang-check.mk
* Add some more comments in main.c

Richard Palethorpe (2):
  Add 'make check' and clang-check to build system
  Start libclang based analyzer and TEST() check

 Makefile                            |   8 +
 configure.ac                        |   2 +
 include/mk/clang-check.mk           |   9 ++
 include/mk/config.mk.in             |   5 +
 include/mk/env_post.mk              |  11 ++
 include/mk/generic_leaf_target.inc  |   5 +-
 include/mk/generic_trunk_target.inc |   7 +-
 include/mk/lib.mk                   |   3 +
 include/mk/rules.mk                 |   9 ++
 include/mk/testcases.mk             |   1 +
 m4/ltp-clang.m4                     |  29 ++++
 tools/clang-check/.gitignore        |   1 +
 tools/clang-check/Makefile          |  35 ++++
 tools/clang-check/main.c            | 238 ++++++++++++++++++++++++++++
 14 files changed, 361 insertions(+), 2 deletions(-)
 create mode 100644 include/mk/clang-check.mk
 create mode 100644 m4/ltp-clang.m4
 create mode 100644 tools/clang-check/.gitignore
 create mode 100644 tools/clang-check/Makefile
 create mode 100644 tools/clang-check/main.c

-- 
2.31.1

