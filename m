From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  9 Oct 2017 13:00:54 +0200
Subject: [LTP] [RFC PATCH v2 0/7] Fix 32-bit cross compilation
Message-ID: <20171009110101.3329-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Minor changes v2->v2:
* New commit "m4: Simplify check for linux/keyctl.h header".
* Fix commits (accidentally remove check for keyutils.h and sys/acl.h headers).

Petr Vorel (7):
  m4: Fix libkeyutils detection on 32-bit cross build
  m4: Fix libacl detection on 32-bit cross build
  m4: Simplify check for linux/can.h header
  m4: Simplify check for linux/keyctl.h header
  m4: Fix libcrypto detection on 32-bit cross build
  make: Remove workarounds for build without libnuma
  m4,kernel/lib: Detect libnuma presence in kernel libs

 configure.ac                                       | 15 +++++++------
 m4/ltp-acl.m4                                      |  7 +++---
 m4/ltp-can.m4                                      | 25 ----------------------
 m4/ltp-crypto.m4                                   | 10 +++++----
 m4/ltp-keyctl.m4                                   | 25 ----------------------
 m4/ltp-keyutils.m4                                 |  6 +++---
 m4/ltp-numa.m4                                     |  6 +++++-
 .../cpuset_syscall_test/cpuset_syscall_test.c      |  4 ++--
 testcases/kernel/hotplug/memory_hotplug/commands.c |  2 +-
 testcases/kernel/hotplug/memory_hotplug/memtoy.c   |  9 ++++----
 testcases/kernel/hotplug/memory_hotplug/segment.c  |  2 +-
 testcases/kernel/include/numa_helper.h             |  2 +-
 testcases/kernel/lib/numa_helper.c                 | 14 ++++++------
 testcases/kernel/mem/cpuset/cpuset01.c             |  4 ++--
 testcases/kernel/mem/ksm/ksm02.c                   |  4 ++--
 testcases/kernel/mem/ksm/ksm04.c                   |  4 ++--
 testcases/kernel/mem/lib/mem.c                     |  6 +++---
 testcases/kernel/mem/vma/vma02.c                   | 17 ++++++---------
 testcases/kernel/mem/vma/vma04.c                   | 16 +++++---------
 .../integrity/ima/src/ima_boot_aggregate.c         | 13 +++++++----
 .../security/integrity/ima/src/ima_measure.c       | 17 +++++++--------
 .../syscalls/get_mempolicy/get_mempolicy01.c       |  4 ++--
 testcases/kernel/syscalls/mbind/Makefile           |  9 --------
 testcases/kernel/syscalls/mbind/mbind01.c          |  4 ++--
 testcases/kernel/syscalls/migrate_pages/Makefile   |  3 ---
 .../syscalls/migrate_pages/migrate_pages02.c       |  2 +-
 testcases/kernel/syscalls/move_pages/Makefile      |  5 -----
 .../syscalls/move_pages/move_pages_support.c       |  8 +++----
 28 files changed, 88 insertions(+), 155 deletions(-)
 delete mode 100644 m4/ltp-can.m4
 delete mode 100644 m4/ltp-keyctl.m4

-- 
2.14.2

