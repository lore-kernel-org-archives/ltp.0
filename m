From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 13:10:54 +0200
Subject: [LTP] [PATCH v5 00/12] Fix 32-bit cross compilation
Message-ID: <20171018111106.17215-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes v4->v5:
* Removed left placeholder in m4/ltp-eventfd.m4
* Removed duplicit libaio.h check in configure.ac.
* Added new commit: kernel/io: Build all directories even without libaio

NOTE: this is also available as a branch on github:
https://github.com/pevik/ltp/tree/autotools/fix-32bit-build.v5

Kind regards,
Petr

Petr Vorel (12):
  m4: Fix libaio detection on 32-bit cross build
  kernel/io: Build all directories even without libaio
  make: Remove workarounds for build without libnuma
  numa: Drop NUMA API v1 support
  numa: Drop NUMA_CPPFLAGS
  hotplug/memory_hotplug: Update TODO
  hotplug/memory_hotplug: Remove unused header
  hotplug/memory_hotplug: Exit with TCONF when NUMA headers not
    available
  m4,kernel/lib: Detect libnuma presence in kernel libs
  numa: Check for API >= v2 with autoconf
  numa: Remove HAVE_NUMA_ALLOC_ONNODE definition
  numa: Remove HAVE_NUMA_MOVE_PAGES definition

 configure.ac                                       |  1 -
 include/config.h.default                           |  3 --
 include/mk/config.mk.default                       |  1 -
 include/mk/config.mk.in                            |  1 -
 m4/ltp-eventfd.m4                                  | 28 +++++++--------
 m4/ltp-numa.m4                                     | 42 +++++++++-------------
 .../controllers/cpuset/cpuset_lib/libcpuset.c      |  1 +
 .../cpuset/cpuset_syscall_test/Makefile            |  1 -
 .../cpuset_syscall_test/cpuset_syscall_test.c      |  5 ++-
 testcases/kernel/hotplug/memory_hotplug/TODO       |  5 ---
 testcases/kernel/hotplug/memory_hotplug/commands.c | 17 +++------
 testcases/kernel/hotplug/memory_hotplug/memtoy.c   | 18 ++++++----
 testcases/kernel/hotplug/memory_hotplug/segment.c  |  7 +++-
 testcases/kernel/include/lib.mk                    |  2 +-
 testcases/kernel/include/numa_helper.h             |  2 +-
 testcases/kernel/io/Makefile                       |  2 --
 testcases/kernel/io/aio/aio01/aio01.c              | 23 ++++++------
 testcases/kernel/io/aio/aio02/aio_tio.c            |  3 +-
 testcases/kernel/io/aio/aio02/main.c               |  8 ++---
 testcases/kernel/io/ltp-aiodio/aio-stress.c        | 15 ++++++--
 testcases/kernel/io/ltp-aiodio/aiocp.c             |  7 ++--
 testcases/kernel/io/ltp-aiodio/aiodio_append.c     | 14 ++++++--
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c     | 18 +++++++---
 testcases/kernel/lib/Makefile                      |  3 +-
 testcases/kernel/lib/numa_helper.c                 | 25 ++++---------
 testcases/kernel/mem/cpuset/cpuset01.c             | 11 +++---
 testcases/kernel/mem/ksm/ksm02.c                   | 10 +++---
 testcases/kernel/mem/ksm/ksm04.c                   | 10 +++---
 testcases/kernel/mem/ksm/ksm06.c                   | 13 ++++---
 testcases/kernel/mem/lib/mem.c                     | 13 ++++---
 testcases/kernel/mem/oom/oom02.c                   | 11 +++---
 testcases/kernel/mem/oom/oom03.c                   | 10 ++++--
 testcases/kernel/mem/oom/oom04.c                   | 11 +++---
 testcases/kernel/mem/oom/oom05.c                   | 11 +++---
 testcases/kernel/mem/vma/vma02.c                   | 16 +++------
 testcases/kernel/mem/vma/vma04.c                   | 15 +++-----
 testcases/kernel/numa/Makefile                     |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c      | 16 ++++++---
 .../syscalls/get_mempolicy/get_mempolicy01.c       | 41 +++------------------
 testcases/kernel/syscalls/io_cancel/io_cancel01.c  | 12 ++++---
 .../kernel/syscalls/io_destroy/io_destroy01.c      | 12 ++++---
 .../kernel/syscalls/io_getevents/io_getevents01.c  | 13 +++----
 testcases/kernel/syscalls/io_setup/io_setup01.c    | 12 ++++---
 testcases/kernel/syscalls/io_submit/io_submit01.c  | 11 +++---
 testcases/kernel/syscalls/mbind/Makefile           |  9 -----
 testcases/kernel/syscalls/mbind/mbind01.c          | 11 +++---
 testcases/kernel/syscalls/migrate_pages/Makefile   |  3 --
 .../syscalls/migrate_pages/migrate_pages01.c       |  9 ++---
 .../syscalls/migrate_pages/migrate_pages02.c       | 10 +++---
 testcases/kernel/syscalls/move_pages/Makefile      |  5 ---
 .../kernel/syscalls/move_pages/move_pages01.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages02.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages03.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages04.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages05.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages06.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages07.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages08.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages09.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages10.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages11.c      |  4 +--
 .../kernel/syscalls/move_pages/move_pages12.c      |  4 +--
 .../syscalls/move_pages/move_pages_support.c       | 18 +++++-----
 63 files changed, 295 insertions(+), 320 deletions(-)

-- 
2.14.2

