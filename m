From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:30 +0200
Subject: [LTP] [PATCH v2 00/11] Introduce guarded buffers
Message-ID: <20190812143941.8119-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes since v1:

* Removed debugging "freeing buffer %p" output and
  added a message that is printed first time tst_alloc() is called.

* Added the missing getpid() to the warning message
  from check_canary()

* Added call to atexit(tst_free_all) in the safe_fork()
  - now we check the canary in child processes as well

* Added documentation into the test-writing-guidelines.txt

* Separated the accept02.c changes from the patch that adds
  the guarded buffers library

Cyril Hrubis (11):
  lib: Add support for guarded buffers
  lib: Add a canary for guarded buffers
  doc: Add guarded buffers documentation
  syscalls/accept02: Make use of guarded buffers.
  syscalls/preadv01: Make use of guarded buffers.
  syscalls/accept4_01: Make use of guarded buffers.
  syscalls/add_key04: Make use of guarded buffers.
  syscalls/adjtimex: Make use of guarded buffers.
  syscalls/clock_getres01: Make use of guarded buffers.
  syscalls/clock_settime01: Make use of guarded buffers.
  syscalls/sendmmsg01: Make use of guarded buffers.

 doc/test-writing-guidelines.txt               |  68 +++++++++
 include/tst_buffers.h                         |  63 ++++++++
 include/tst_test.h                            |   6 +
 lib/newlib_tests/.gitignore                   |   1 +
 lib/newlib_tests/test_guarded_buf.c           |  92 +++++++++++
 lib/tst_buffers.c                             | 143 ++++++++++++++++++
 lib/tst_test.c                                |   8 +
 testcases/kernel/syscalls/accept/accept02.c   |  41 ++---
 .../kernel/syscalls/accept4/accept4_01.c      |  24 +--
 testcases/kernel/syscalls/add_key/add_key04.c |  13 +-
 .../kernel/syscalls/adjtimex/adjtimex01.c     |  23 +--
 .../kernel/syscalls/adjtimex/adjtimex02.c     |  39 ++---
 .../syscalls/clock_getres/clock_getres01.c    |  12 +-
 .../syscalls/clock_settime/clock_settime01.c  |  29 ++--
 testcases/kernel/syscalls/preadv/preadv01.c   |  10 +-
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  68 ++++-----
 16 files changed, 528 insertions(+), 112 deletions(-)
 create mode 100644 include/tst_buffers.h
 create mode 100644 lib/newlib_tests/test_guarded_buf.c
 create mode 100644 lib/tst_buffers.c

-- 
2.21.0

