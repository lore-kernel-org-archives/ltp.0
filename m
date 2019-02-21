From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Feb 2019 14:30:07 +0530
Subject: [LTP] [PATCH v4 0/9] syscalls: add sync device test-cases
Message-ID: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch-set adds common test for minimal sectors written on device
for various sync related syscalls:
1. syncfs()
2. sync()
3. fsync()
4. fdatasync()
5. sync_file_range()

Also this test is run on all supported filesystems on a test block
device.

Changes in v4:
1. Update common library functions from reusability perspective.
2. Create separate patch for TEST_VOID macro.
3. Add check for broken /sys/block/<device>/stat file.
4. Miscellaneous fixups.

Changes in v3:
1. Scope increased from single patch to this patch-set to add common
   test for sync(), fsync(), fdatasync() and sync_file_range() syscalls.
2. Move common functionality to library functions.
3. Use %lu rather than %s while parsing sectors written.
4. Add config check for C library wrapper and fallback definition for
   syncfs() and sync_file_range() syscalls.

Changes in v2:
1. Remove unused header file include.
2. Remove redundant tst_device check.
3. Remove redundant flags from tst_test struct.

Fixes: https://github.com/linux-test-project/ltp/issues/294

Sumit Garg (9):
  lib/tst_device: add new api tst_dev_bytes_written()
  lib: split tst_fill_file() to create new tst_fill_fd()
  lib/tst_test: define TEST_VOID() macro
  syscalls: add syncfs() sync device test-case
  syscalls/sync: add sync device test-case
  syscalls/fsync: add sync device test-case
  syscalls/fdatasync: add sync device test-case
  syscalls/sync_file_range: Use C library wrapper if present
  syscalls/sync_file_range: add sync device test-case

 configure.ac                                       |  2 +
 include/lapi/sync_file_range.h                     | 57 +++++++++++++++++
 include/lapi/syncfs.h                              | 21 +++++++
 include/tst_device.h                               |  7 +++
 include/tst_fs.h                                   |  9 +++
 include/tst_test.h                                 |  7 +++
 lib/tst_device.c                                   | 29 +++++++++
 lib/tst_fill_file.c                                | 40 +++++++-----
 m4/ltp-sync_file_range.m4                          | 10 +++
 m4/ltp-syncfs.m4                                   | 10 +++
 runtest/syscalls                                   |  6 ++
 testcases/kernel/syscalls/fdatasync/.gitignore     |  1 +
 testcases/kernel/syscalls/fdatasync/fdatasync03.c  | 60 ++++++++++++++++++
 testcases/kernel/syscalls/fsync/.gitignore         |  1 +
 testcases/kernel/syscalls/fsync/fsync04.c          | 60 ++++++++++++++++++
 testcases/kernel/syscalls/sync/.gitignore          |  1 +
 testcases/kernel/syscalls/sync/sync03.c            | 60 ++++++++++++++++++
 .../kernel/syscalls/sync_file_range/.gitignore     |  1 +
 .../sync_file_range/check_sync_file_range.h        | 21 +++++++
 .../syscalls/sync_file_range/sync_file_range01.c   | 62 ++-----------------
 .../syscalls/sync_file_range/sync_file_range02.c   | 72 ++++++++++++++++++++++
 testcases/kernel/syscalls/syncfs/.gitignore        |  1 +
 testcases/kernel/syscalls/syncfs/Makefile          |  8 +++
 testcases/kernel/syscalls/syncfs/check_syncfs.h    | 19 ++++++
 testcases/kernel/syscalls/syncfs/syncfs01.c        | 67 ++++++++++++++++++++
 25 files changed, 558 insertions(+), 74 deletions(-)
 create mode 100644 include/lapi/sync_file_range.h
 create mode 100644 include/lapi/syncfs.h
 create mode 100644 m4/ltp-sync_file_range.m4
 create mode 100644 m4/ltp-syncfs.m4
 create mode 100644 testcases/kernel/syscalls/fdatasync/fdatasync03.c
 create mode 100644 testcases/kernel/syscalls/fsync/fsync04.c
 create mode 100644 testcases/kernel/syscalls/sync/sync03.c
 create mode 100644 testcases/kernel/syscalls/sync_file_range/check_sync_file_range.h
 create mode 100644 testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
 create mode 100644 testcases/kernel/syscalls/syncfs/.gitignore
 create mode 100644 testcases/kernel/syscalls/syncfs/Makefile
 create mode 100644 testcases/kernel/syscalls/syncfs/check_syncfs.h
 create mode 100644 testcases/kernel/syscalls/syncfs/syncfs01.c

-- 
2.7.4

