From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Sep 2020 17:01:47 +0200
Subject: [LTP] [PATCH v2 00/10] Rewrite shmctl() testcases
Message-ID: <20200907150157.23886-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset mostly rewrites old shmctl testcases from scratch and also
increases the coverage at least threefold.

There are still missing pieces though, there are no test that would
check that shm_atime and shm_dtime are valid as well as shm_lpid as well
as the coverage of ipc_perm is still lacking and should be added later
on.

Changes in v2:

* Redesing shmctl04, the check for max_idx was bogus before

* Fixed shmctl07 to re-read the IPC_STAT and corrected the check

* Fixed shmctl08 ctime check to make sure the field gets updated

* Added fallback for SHM_STAT_ANY

+ Many smaller fixes mostly pointed out by Martin

Cyril Hrubis (10):
  syscalls/ipc: shmctl02: Convert to the new library
  syscalls/ipc: shmctl03: Remove.
  lapi/shm.h: Add SHM_STAT_ANY
  syscalls/ipc: shmctl04: Rewrite from scratch.
  syscalls/ipc: shmctl05 remove lib dependency
  lib/tst_assert: Add TST_ASSERT_ULONG()
  syscalls/ipc: Add shmctl() IPC_INFO test
  syscalls/ipc: Add shmctl07 test
  syscalls/ipc: Add shmctl IPC_SET test
  syscalls/ipc: Rewrite shmctl01

 include/lapi/shm.h                            |  13 +
 include/tst_assert.h                          |   9 +
 lib/tst_assert.c                              |  14 +
 runtest/syscalls                              |   2 +
 runtest/syscalls-ipc                          |   2 +
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   2 +
 testcases/kernel/syscalls/ipc/shmctl/Makefile |   3 +-
 .../kernel/syscalls/ipc/shmctl/shmctl01.c     | 586 ++++++------------
 .../kernel/syscalls/ipc/shmctl/shmctl02.c     | 263 +++-----
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 216 +------
 .../kernel/syscalls/ipc/shmctl/shmctl04.c     | 203 +++---
 .../kernel/syscalls/ipc/shmctl/shmctl07.c     |  68 ++
 .../kernel/syscalls/ipc/shmctl/shmctl08.c     | 103 +++
 13 files changed, 625 insertions(+), 859 deletions(-)
 create mode 100644 include/lapi/shm.h
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c

-- 
2.26.2

