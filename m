From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Aug 2019 11:26:07 +0200
Subject: [LTP] [RFC PATCH 0/9] Introduce guarded buffers
Message-ID: <20190801092616.30553-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is initial attempt to implement:

https://github.com/linux-test-project/ltp/issues/531

The idea of guarded buffers is that with these buffers undefined
behavior and possibly silent memory corruptions are turned into
segfaults which is much easier to spot and debug.

The first two commits introduce API for allocating guarded buffers with
poisoned PROT_NONE page right after the buffer and canary before the
buffer. Tests using these buffers will catch any access after the buffer
and writes before the buffer.

The next few patches make use of the buffers in a few tests mostly to
show the intended usage in real testcases. Applying these buffers to the
rest of the testcases would need much more effort though.

Cyril Hrubis (9):
  lib: Add support for guarded buffers
  lib: Add a canary for guarded buffers
  syscalls/preadv01: Make use of guarded buffers.
  syscalls/accept4_01: Make use of guarded buffers.
  syscalls/add_key04: Make use of guarded buffers.
  syscalls/adjtimex: Make use of guarded buffers.
  syscalls/clock_getres01: Make use of guarded buffers.
  syscalls/clock_settime01: Make use of guarded buffers.
  syscalls/sendmmsg01: Make use of guarded buffers.

 include/tst_buffers.h                         |  63 ++++++++
 include/tst_test.h                            |   6 +
 lib/newlib_tests/.gitignore                   |   1 +
 lib/newlib_tests/test_guarded_buf.c           |  86 +++++++++++
 lib/tst_buffers.c                             | 138 ++++++++++++++++++
 lib/tst_test.c                                |   5 +
 testcases/kernel/syscalls/accept/accept02.c   |  41 +++---
 .../kernel/syscalls/accept4/accept4_01.c      |  24 +--
 testcases/kernel/syscalls/add_key/add_key04.c |  13 +-
 .../kernel/syscalls/adjtimex/adjtimex01.c     |  23 +--
 .../kernel/syscalls/adjtimex/adjtimex02.c     |  39 ++---
 .../syscalls/clock_getres/clock_getres01.c    |  12 +-
 .../syscalls/clock_settime/clock_settime01.c  |  29 ++--
 testcases/kernel/syscalls/preadv/preadv01.c   |  10 +-
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  68 +++++----
 15 files changed, 446 insertions(+), 112 deletions(-)
 create mode 100644 include/tst_buffers.h
 create mode 100644 lib/newlib_tests/test_guarded_buf.c
 create mode 100644 lib/tst_buffers.c

-- 
2.21.0

