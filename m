From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:32 -0800
Subject: [LTP] [PATCH 0/6] Miscellaneous fixes for Android systems
Message-ID: <20171109003438.130802-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

We have been running LTP on Android systems and found there are a bunch of
tests that don't work. Most common reasons are (but not limited to):
 - Lack of tools that LTP tests sometimes expects (e.g. mkfs.extN)
 - Different directory structure or location for device nodes
   (e.g. /dev/block/loopX instead of /dev/loopX)
 - Tests depend on Sys V IPC that Android doesn't use / support.

This series fixes some of those tests to make sure they start working on
Android systems. I've also clubbed the v2 of a couple of patches in this
series that they are clearly annotated as such.


Sandeep Patil (6):
  syscalls/cma: Make process_vm_{readv, writev} tests bionic friendly
  mm: mallocstress: use safe macros wherever possible
  mm: mallocstress: use futexes instead of SysV semaphores
  direct_io: diotest4: use getpagesize() for mmap if shm header is
    absent
  syscalls/mkdir03: convert to new API and use .needsrofs for EROFS
    check
  lib: mkfs: use 'mke2fs' on android systems for formatting filesystems

 configure.ac                                       |   1 +
 include/lapi/mmap.h                                |   8 ++
 lib/tst_mkfs.c                                     |  16 +++
 testcases/kernel/io/direct_io/diotest4.c           |   4 +-
 testcases/kernel/mem/mtest07/mallocstress.c        | 101 +++++---------
 testcases/kernel/syscalls/cma/process_vm.h         |  38 ------
 testcases/kernel/syscalls/cma/process_vm_readv02.c |  10 +-
 testcases/kernel/syscalls/cma/process_vm_readv03.c |  10 +-
 .../kernel/syscalls/cma/process_vm_writev02.c      |  10 +-
 testcases/kernel/syscalls/mkdir/mkdir03.c          | 147 ++++++---------------
 10 files changed, 115 insertions(+), 230 deletions(-)

-- 
2.15.0.448.gf294e3d99a-goog

