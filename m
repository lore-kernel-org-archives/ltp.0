From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:17 +0200
Subject: [LTP] [PATCH v3 00/18] Fix 32-bit cross compilation
Message-ID: <20171012183335.24568-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I tested HEAD against:
./configure "CFLAGS=-m32" "CXXFLAGS=-m32" LDFLAGS="-m32" && make && make install
(I know we don't really need CXXFLAGS)

and each commit against normal build.

Petr Vorel (18):
  configure.ac: Sort headers alphabetically
  m4: Simplify check for linux/can.h header
  m4: Simplify check for linux/keyctl.h header
  lapi/keyctl.h: Add doc and reorder definitions
  syscalls/request_key: Port to use lapi/keyctl.h header
  m4: Fix libkeyutils detection on 32-bit cross build
  nfsv4/acl1: Exit with TCONF when libacl not available
  m4: Fix libacl detection on 32-bit cross build
  m4: Fix libcrypto detection on 32-bit cross build
  io/aiocp: Exit with TCONF when libaio is not available
  m4: Fix libaio detection on 32-bit cross build
  make: Remove workarounds for build without libnuma
  numa: Drop NUMA API v1 support
  numa: Drop NUMA_CPPFLAGS
  hotplug/memory_hotplug: Update TODO
  hotplug/memory_hotplug: Remove unused header
  hotplug/memory_hotplug: Exit with TCONF when NUMA headers not
    available
  m4,kernel/lib: Detect libnuma presence in kernel libs

 configure.ac                                       | 13 +++---
 include/lapi/keyctl.h                              | 53 +++++++++++++++++-----
 include/mk/config.mk.default                       |  1 -
 include/mk/config.mk.in                            |  1 -
 m4/ltp-acl.m4                                      | 12 +++--
 m4/ltp-can.m4                                      | 25 ----------
 m4/ltp-crypto.m4                                   | 11 +++--
 m4/ltp-eventfd.m4                                  | 17 ++++---
 m4/ltp-keyctl.m4                                   | 25 ----------
 m4/ltp-keyutils.m4                                 |  7 +--
 m4/ltp-numa.m4                                     | 45 ++++++++----------
 .../controllers/cpuset/cpuset_lib/libcpuset.c      |  1 +
 .../cpuset/cpuset_syscall_test/Makefile            |  1 -
 .../cpuset_syscall_test/cpuset_syscall_test.c      |  5 +-
 testcases/kernel/hotplug/memory_hotplug/TODO       |  5 --
 testcases/kernel/hotplug/memory_hotplug/commands.c | 17 ++-----
 testcases/kernel/hotplug/memory_hotplug/memtoy.c   | 17 ++++---
 testcases/kernel/hotplug/memory_hotplug/segment.c  |  6 ++-
 testcases/kernel/include/lib.mk                    |  2 +-
 testcases/kernel/include/numa_helper.h             |  2 +-
 testcases/kernel/io/aio/aio01/aio01.c              | 23 ++++------
 testcases/kernel/io/aio/aio02/aio_tio.c            |  3 +-
 testcases/kernel/io/aio/aio02/main.c               |  8 ++--
 testcases/kernel/io/ltp-aiodio/aio-stress.c        | 15 +++++-
 testcases/kernel/io/ltp-aiodio/aiocp.c             | 11 ++---
 testcases/kernel/io/ltp-aiodio/aiodio_append.c     | 14 +++++-
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c     | 18 ++++++--
 testcases/kernel/lib/Makefile                      |  3 +-
 testcases/kernel/lib/numa_helper.c                 | 25 +++-------
 testcases/kernel/mem/cpuset/cpuset01.c             |  8 ++--
 testcases/kernel/mem/ksm/ksm02.c                   |  9 ++--
 testcases/kernel/mem/ksm/ksm04.c                   |  9 ++--
 testcases/kernel/mem/ksm/ksm06.c                   | 12 +++--
 testcases/kernel/mem/lib/mem.c                     | 13 +++---
 testcases/kernel/mem/oom/oom02.c                   |  9 ++--
 testcases/kernel/mem/oom/oom03.c                   | 10 ++--
 testcases/kernel/mem/oom/oom04.c                   |  9 ++--
 testcases/kernel/mem/oom/oom05.c                   |  9 ++--
 testcases/kernel/mem/vma/vma02.c                   | 14 ++----
 testcases/kernel/mem/vma/vma04.c                   | 13 ++----
 testcases/kernel/numa/Makefile                     |  2 +-
 .../integrity/ima/src/ima_boot_aggregate.c         | 21 +++++----
 .../security/integrity/ima/src/ima_measure.c       | 24 +++++-----
 testcases/kernel/syscalls/eventfd/eventfd01.c      | 16 +++++--
 .../syscalls/get_mempolicy/get_mempolicy01.c       | 41 ++---------------
 testcases/kernel/syscalls/io_cancel/io_cancel01.c  | 12 +++--
 .../kernel/syscalls/io_destroy/io_destroy01.c      | 12 +++--
 .../kernel/syscalls/io_getevents/io_getevents01.c  | 13 +++---
 testcases/kernel/syscalls/io_setup/io_setup01.c    | 12 +++--
 testcases/kernel/syscalls/io_submit/io_submit01.c  | 11 +++--
 testcases/kernel/syscalls/mbind/Makefile           |  9 ----
 testcases/kernel/syscalls/mbind/mbind01.c          |  9 ++--
 testcases/kernel/syscalls/migrate_pages/Makefile   |  3 --
 .../syscalls/migrate_pages/migrate_pages01.c       |  8 ++--
 .../syscalls/migrate_pages/migrate_pages02.c       |  9 ++--
 testcases/kernel/syscalls/move_pages/Makefile      |  5 --
 .../syscalls/move_pages/move_pages_support.c       | 14 +++---
 .../kernel/syscalls/request_key/request_key01.c    | 14 +-----
 .../kernel/syscalls/request_key/request_key02.c    | 15 +-----
 testcases/network/nfsv4/acl/acl1.c                 | 24 ++--------
 60 files changed, 359 insertions(+), 416 deletions(-)
 delete mode 100644 m4/ltp-can.m4
 delete mode 100644 m4/ltp-keyctl.m4

-- 
2.14.2

