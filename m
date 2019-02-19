From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 14:58:13 +0530
Subject: [LTP] [PATCH v3 0/7] syscalls: add sync device test-cases
Message-ID: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
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

Sumit Garg (7):
  lib: Add library functions for sync related syscalls
  syscalls: add syncfs() sync device test-case
  syscalls/sync: add sync device test-case
  syscalls/fsync: add sync device test-case
  syscalls/fdatasync: add sync device test-case
  syscalls/sync_file_range: Use C library wrapper if present
  syscalls/sync_file_range: add sync device test-case

 configure.ac                                       |  2 +
 include/lapi/sync_file_range.h                     | 64 +++++++++++++++++
 include/lapi/syncfs.h                              | 21 ++++++
 include/tst_sync_device.h                          | 17 +++++
 include/tst_test.h                                 |  7 ++
 lib/tst_sync_device.c                              | 80 ++++++++++++++++++++++
 m4/ltp-sync_file_range.m4                          | 10 +++
 m4/ltp-syncfs.m4                                   | 10 +++
 runtest/syscalls                                   |  6 ++
 testcases/kernel/syscalls/fdatasync/.gitignore     |  1 +
 testcases/kernel/syscalls/fdatasync/fdatasync03.c  | 61 +++++++++++++++++
 testcases/kernel/syscalls/fsync/.gitignore         |  1 +
 testcases/kernel/syscalls/fsync/fsync04.c          | 61 +++++++++++++++++
 testcases/kernel/syscalls/sync/.gitignore          |  1 +
 testcases/kernel/syscalls/sync/sync03.c            | 59 ++++++++++++++++
 .../kernel/syscalls/sync_file_range/.gitignore     |  1 +
 .../sync_file_range/check_sync_file_range.h        | 23 +++++++
 .../syscalls/sync_file_range/sync_file_range01.c   | 62 ++---------------
 .../syscalls/sync_file_range/sync_file_range02.c   | 70 +++++++++++++++++++
 testcases/kernel/syscalls/syncfs/.gitignore        |  1 +
 testcases/kernel/syscalls/syncfs/Makefile          |  8 +++
 testcases/kernel/syscalls/syncfs/check_syncfs.h    | 19 +++++
 testcases/kernel/syscalls/syncfs/syncfs01.c        | 64 +++++++++++++++++
 23 files changed, 592 insertions(+), 57 deletions(-)
 create mode 100644 include/lapi/sync_file_range.h
 create mode 100644 include/lapi/syncfs.h
 create mode 100644 include/tst_sync_device.h
 create mode 100644 lib/tst_sync_device.c
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

