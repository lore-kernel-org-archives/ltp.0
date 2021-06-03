From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Jun 2021 16:48:23 +0100
Subject: [LTP] [RFC PATCH 0/2] Libclang based analyzer
Message-ID: <20210603154825.30165-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This implements a TEST() check and integrates the check into the build
system.

Compared to the Coccinelle version it's very ugly. However I think
this will allow us to get all the low hanging fruit without creating
major problems for test developers.

I guess it could be run during CI if we either fix all the existing
TEST() usages in the library or add an ignore list. I already have a
Coccinelle script to help with the former.

Richard Palethorpe (2):
  Add 'make checks' and clang-checks to build system
  Start libclang based analyzer and TEST() check

 configure.ac                       |   2 +
 include/mk/config.mk.in            |   5 +
 include/mk/env_post.mk             |   8 ++
 include/mk/generic_leaf_target.inc |   5 +-
 include/mk/lib.mk                  |   3 +
 include/mk/rules.mk                |   9 ++
 include/mk/testcases.mk            |   1 +
 tools/clang-checks/.gitignore      |   1 +
 tools/clang-checks/Makefile        |  13 ++
 tools/clang-checks/main.c          | 218 +++++++++++++++++++++++++++++
 10 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 tools/clang-checks/.gitignore
 create mode 100644 tools/clang-checks/Makefile
 create mode 100644 tools/clang-checks/main.c

-- 
2.31.1

