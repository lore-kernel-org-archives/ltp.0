From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 29 Jun 2021 08:27:03 +0100
Subject: [LTP] [PATCH 0/7] Sparse based checker and rule proposal
Message-ID: <20210629072710.23800-1-rpalethorpe@suse.com>
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
Richard Palethorpe (7):
  Add Sparse based checker and TST_RET/ERR check
  Add 'make check' to the build system
  meltdown: Set CFLAGS for check targets
  doc: Add rules and recommendations list
  doc: Remind authors and maintainers to run make check
  doc: Document TEST macro and state TST_RET/ERR rule LTP-002
  Reference LTP-002 rule in Cocci scripts

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
 .../coccinelle/libltp-test-macro-vars.cocci   |   6 +-
 scripts/coccinelle/libltp-test-macro.cocci    |   4 +-
 testcases/cve/Makefile                        |   1 +
 testcases/open_posix_testsuite/Makefile       |   4 +
 tools/sparse/.gitignore                       |   1 +
 tools/sparse/Makefile                         |  20 +++
 tools/sparse/README.md                        |  34 ++++
 tools/sparse/main.c                           | 148 ++++++++++++++++++
 tools/sparse/sparse-src                       |   1 +
 24 files changed, 335 insertions(+), 11 deletions(-)
 create mode 100644 doc/rules.tsv
 create mode 100644 include/mk/sparse.mk
 create mode 100644 tools/sparse/.gitignore
 create mode 100644 tools/sparse/Makefile
 create mode 100644 tools/sparse/README.md
 create mode 100644 tools/sparse/main.c
 create mode 160000 tools/sparse/sparse-src

-- 
2.31.1

