From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  4 Jun 2021 12:14:32 +0100
Subject: [LTP] [RFC PATCH v2 0/2] Libclang based analyzer
Message-ID: <20210604111434.21422-1-rpalethorpe@suse.com>
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

V2:
* Consistently use singular form of 'check'
* Include missing clang-check.mk
* Add some more comments in main.c

Richard Palethorpe (2):
  Add 'make check' and clang-check to build system
  Start libclang based analyzer and TEST() check

 configure.ac                       |   2 +
 include/mk/clang-check.mk          |   9 ++
 include/mk/config.mk.in            |   5 +
 include/mk/env_post.mk             |   8 +
 include/mk/generic_leaf_target.inc |   5 +-
 include/mk/lib.mk                  |   3 +
 include/mk/rules.mk                |   9 ++
 include/mk/testcases.mk            |   1 +
 tools/clang-check/.gitignore       |   1 +
 tools/clang-check/Makefile         |  14 ++
 tools/clang-check/main.c           | 239 +++++++++++++++++++++++++++++
 11 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 include/mk/clang-check.mk
 create mode 100644 tools/clang-check/.gitignore
 create mode 100644 tools/clang-check/Makefile
 create mode 100644 tools/clang-check/main.c

-- 
2.31.1

