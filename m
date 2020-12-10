From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Dec 2020 15:15:38 +0100
Subject: [LTP] [PATCH v2 00/10] Introduce TST_EXP_MACROS
Message-ID: <20201210141548.10982-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset adds TST_EXP_MACROS() implementation.

These macros are intended to simplify and unify syscall unit tests.

This patchset converts a few testcases to use TST_EXP_MACROS() it's
intenteded to serve as an example since there is a lot of testcases that
could use them as well.

Also the documentation for these macros is ommited at this point, I will
add it in a case that we agree to include them in the test library.


Changes in v2:

- renamed the macros so that it's more clear that they do
- added documentation to test-writing-guidelines
- minor fixed in the converted testcases

Cyril Hrubis (10):
  lib: Introduce TST_EXP_* macros
  syscalls/uname: Make use of TST_EXP_MACROS
  syscalls/accept: Make use of TST_EXP_MACROS
  syscalls/access: Make use of TST_EXP_MACROS
  syscalls/bind: Make use of TST_EXP_MACROS
  syscalls/brk01: Make use of TST_EXP_MACROS
  syscalls/cacheflush: Make use of TST_EXP_MACROS
  syscalls/capget: Make use of TEST_MACROS
  syscalls/capset: Make use of TST_EXP_MACROS
  syscalls/open: Make use of TST_EXP_MACROS

 doc/test-writing-guidelines.txt               |  54 ++++++++
 include/tst_test.h                            |  28 +---
 include/tst_test_macros.h                     | 130 ++++++++++++++++++
 lib/newlib_tests/.gitignore                   |   3 +
 lib/newlib_tests/test_macros01.c              |  40 ++++++
 lib/newlib_tests/test_macros02.c              |  42 ++++++
 lib/newlib_tests/test_macros03.c              |  40 ++++++
 lib/tst_test.c                                |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |  17 +--
 testcases/kernel/syscalls/access/access01.c   |  45 +-----
 testcases/kernel/syscalls/access/access02.c   |   8 +-
 testcases/kernel/syscalls/access/access03.c   |  28 +---
 testcases/kernel/syscalls/access/access04.c   |  17 +--
 testcases/kernel/syscalls/bind/bind01.c       |  12 +-
 testcases/kernel/syscalls/bind/bind02.c       |  11 +-
 testcases/kernel/syscalls/bind/bind03.c       |  26 +---
 testcases/kernel/syscalls/bind/bind04.c       |   5 +-
 testcases/kernel/syscalls/bind/bind05.c       |   5 +-
 testcases/kernel/syscalls/brk/brk01.c         |   9 +-
 .../kernel/syscalls/cacheflush/cacheflush01.c |   8 +-
 testcases/kernel/syscalls/capget/capget01.c   |  17 +--
 testcases/kernel/syscalls/capget/capget02.c   |  26 ++--
 testcases/kernel/syscalls/capset/capset01.c   |  14 +-
 testcases/kernel/syscalls/capset/capset02.c   |  28 ++--
 testcases/kernel/syscalls/capset/capset03.c   |  10 +-
 testcases/kernel/syscalls/capset/capset04.c   |  13 +-
 testcases/kernel/syscalls/open/open01.c       |  11 +-
 testcases/kernel/syscalls/open/open02.c       |  25 +---
 testcases/kernel/syscalls/open/open11.c       |  22 ++-
 testcases/kernel/syscalls/uname/uname01.c     |  13 +-
 testcases/kernel/syscalls/uname/uname02.c     |  17 +--
 31 files changed, 403 insertions(+), 322 deletions(-)
 create mode 100644 include/tst_test_macros.h
 create mode 100644 lib/newlib_tests/test_macros01.c
 create mode 100644 lib/newlib_tests/test_macros02.c
 create mode 100644 lib/newlib_tests/test_macros03.c

-- 
2.26.2

