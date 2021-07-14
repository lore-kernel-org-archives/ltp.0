From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Jul 2021 08:11:50 +0100
Subject: [LTP] [PATCH v2 0/8] Sparse based checker and rule proposal
Message-ID: <20210714071158.15868-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

So it turns out that it is quite easy to implement the TST_RET/ERR
check in Sparse. It compiles the code into an IR which is just the
right abstraction for the test. It is also possible to inspect the AST
with Sparse. It appears more difficult to inspect the AST before
macros are expanded.

Sparse is not packaged as a shared library, but has few/no
dependencies and is easy to compile. It seems like it was meant to be
vendored. Including it as a git module seems reasonable to me. Please
see tools/sparse/README.md.

There are still a lot of errors/noise when running 'make check' on the
entire tree. These are mainly caused by old function definitions and
such. They need to be fixed before the tool can be used properly.

Also I have tried to document the rule and created a list of rules. So
this can also be taken as a formal proposal for the rule itself.

Thanks,

V2:
* Automatically download and build sparse.
* Only build sparse if "make check" is run. It is filtered from "make all".
* Move libtsc.h out of the realtime tests dir. Note that checking of metldown.c
  now fails because it uses a GCC builtin sparse does not recognize.

As mentioned above, there are various errors during checking that need
fixing. For the most part these are legit errors (usually old style
function definitions or redefining of symbols). With stuff like
metldown I am tempted to filter it, but OTOH it looks relatively
straight forward to add a builtin to Sparse upstream. I just need time
to do it. First though I would like to get "make check" working on the
library, so we can put that in CI.

Richard Palethorpe (8):
  Add Sparse based checker and TST_RET/ERR check
  Add 'make check' to the build system
  doc: Add rules and recommendations list
  doc: Remind authors and maintainers to run make check
  doc: Document TEST macro and state TST_RET/ERR rule LTP-002
  Reference LTP-002 rule in Cocci scripts
  API: Move libtsc.h from realtime tests include to tst_tsc.h
  API/tst_tsc: Add guards and remove some boilerplate

 .gitmodules                                   |   3 +
 Makefile                                      |   8 +
 doc/c-test-api.txt                            |  47 ++++++
 doc/library-api-writing-guidelines.txt        |  14 ++
 doc/maintainer-patch-review-checklist.txt     |   2 +-
 doc/rules.tsv                                 |   3 +
 doc/test-writing-guidelines.txt               |   6 +
 include/mk/env_post.mk                        |   8 +
 include/mk/generic_leaf_target.inc            |   5 +-
 include/mk/generic_trunk_target.inc           |   7 +-
 include/mk/lib.mk                             |   3 +
 include/mk/module.mk                          |   2 +
 include/mk/rules.mk                           |   9 ++
 include/mk/sparse.mk                          |   9 ++
 include/mk/testcases.mk                       |   1 +
 .../include/libtsc.h => include/tst_tsc.h     |  35 +----
 .../coccinelle/libltp-test-macro-vars.cocci   |   6 +-
 scripts/coccinelle/libltp-test-macro.cocci    |   4 +-
 testcases/cve/Makefile                        |   2 -
 testcases/cve/meltdown.c                      |   2 +-
 testcases/open_posix_testsuite/Makefile       |   4 +
 .../func/async_handler/async_handler_tsc.c    |   3 +-
 .../func/measurement/preempt_timing.c         |   3 +-
 .../realtime/func/measurement/rdtsc-latency.c |   3 +-
 tools/Makefile                                |   2 +
 tools/sparse/.gitignore                       |   1 +
 tools/sparse/Makefile                         |  27 ++++
 tools/sparse/README.md                        |  38 +++++
 tools/sparse/main.c                           | 148 ++++++++++++++++++
 tools/sparse/sparse-src                       |   1 +
 30 files changed, 362 insertions(+), 44 deletions(-)
 create mode 100644 doc/rules.tsv
 create mode 100644 include/mk/sparse.mk
 rename testcases/realtime/include/libtsc.h => include/tst_tsc.h (53%)
 create mode 100644 tools/sparse/.gitignore
 create mode 100644 tools/sparse/Makefile
 create mode 100644 tools/sparse/README.md
 create mode 100644 tools/sparse/main.c
 create mode 160000 tools/sparse/sparse-src

-- 
2.31.1

