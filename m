From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Oct 2020 12:04:44 +0100
Subject: [LTP] [PATCH v2 0/2] Add support for kconfig constraints
Message-ID: <20201027110446.20416-1-chrubis@suse.cz>
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

 doc/test-writing-guidelines.txt  |  21 +-
 include/tst_bool_expr.h          |  80 ++++++
 include/tst_kconfig.h            |  34 +--
 lib/newlib_tests/.gitignore      |   1 +
 lib/newlib_tests/config06        |   1 +
 lib/newlib_tests/test_kconfig.c  |   1 +
 lib/newlib_tests/tst_bool_expr.c | 128 ++++++++++
 lib/tst_bool_expr.c              | 425 +++++++++++++++++++++++++++++++
 lib/tst_kconfig.c                | 362 +++++++++++++++++---------
 9 files changed, 904 insertions(+), 149 deletions(-)
 create mode 100644 include/tst_bool_expr.h
 create mode 100644 lib/newlib_tests/config06
 create mode 100644 lib/newlib_tests/tst_bool_expr.c
 create mode 100644 lib/tst_bool_expr.c

-- 
2.26.2

