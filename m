From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Mar 2019 18:11:32 +0100
Subject: [LTP] [PATCH v3 0/2] Implement syscall variants
Message-ID: <20190322171134.899-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is version 3 of the patchset, the main change is that the
previously called multiplexing is now hooked up much sooner in the
library, before we fork and run test setup().

The advange of this is that tests that exit with tst_brk(TCONF, ...) do
not exit the whole testsuite this way and also different test variants
are better isolated as well.

As a side effect the API has been simplified as well.

Cyril Hrubis (2):
  tst_test: Add test multiplex function
  syscalls/select04: Test four syscall variants

 doc/test-writing-guidelines.txt               | 66 +++++++++++++++
 include/tst_test.h                            | 12 +++
 lib/newlib_tests/.gitignore                   |  1 +
 lib/newlib_tests/variant.c                    | 55 +++++++++++++
 lib/tst_test.c                                | 22 +++--
 testcases/kernel/syscalls/select/select04.c   |  7 +-
 testcases/kernel/syscalls/select/select_var.h | 82 +++++++++++++++++++
 7 files changed, 239 insertions(+), 6 deletions(-)
 create mode 100644 lib/newlib_tests/variant.c
 create mode 100644 testcases/kernel/syscalls/select/select_var.h

-- 
2.19.2

