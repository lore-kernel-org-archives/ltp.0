From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Nov 2020 12:38:19 +0100
Subject: [LTP] [PATCH v3 0/2] Add support for kconfig constraints
Message-ID: <20201103113821.6820-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset adds a support for generic boolean expressions in order to
be able to check for a more complex kernel configurations.

The motivation for this is recent rename in kernel config names that
cannot be checked for by a simplistic approach we previously
implemented.

The boolean expression parser was written as a generic as possible since
I do expect that we will reuse it for different types of assertions in
the future.

Cyril Hrubis (2):
  lib: Add generic boolean expression parser and eval
  lib/tst_kconfig: Make use of boolean expression eval

 doc/test-writing-guidelines.txt         |  21 +-
 include/tst_bool_expr.h                 |  86 +++++
 include/tst_kconfig.h                   |  34 +-
 lib/newlib_tests/.gitignore             |   2 +
 lib/newlib_tests/config06               |   1 +
 lib/newlib_tests/test_kconfig.c         |   2 +
 lib/newlib_tests/test_kconfig01.c       |  23 ++
 lib/newlib_tests/tst_bool_expr.c        | 128 ++++++++
 lib/tst_bool_expr.c                     | 411 ++++++++++++++++++++++++
 lib/tst_kconfig.c                       | 366 ++++++++++++++-------
 testcases/kernel/syscalls/acct/acct02.c |  14 +-
 11 files changed, 933 insertions(+), 155 deletions(-)
 create mode 100644 include/tst_bool_expr.h
 create mode 100644 lib/newlib_tests/config06
 create mode 100644 lib/newlib_tests/test_kconfig01.c
 create mode 100644 lib/newlib_tests/tst_bool_expr.c
 create mode 100644 lib/tst_bool_expr.c

-- 
2.26.2

