From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 11 Feb 2021 11:03:12 +0000
Subject: [LTP] [PATCH 0/5] Add close_range01, SAFE_DUP2 and SAFE_CLONE
Message-ID: <20210211110317.31942-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This series adds a test for the new system call close_range. The
kernel selftests already added some tests, so I based this on those.

Also of note, is the addition of tst_clone and SAFE_CLONE which mirror
the clone3 interface. This is not really necessary for this test as it
is unlikely close_range is backported, but clone3 is not. OTOH I think
it will be usefull for other tests especially as the libc clone
wrapper seems to force the user to allocate the stack even though the
kernel can handle this. Also the clone_args is growing rapidly.

The old API has ltp_clone* functions, but I think we will have an
easier time tracking the clone3 interface, than what we were doing
with the old API.

Richard Palethorpe (5):
  close_range: Add syscall number
  API: Add SAFE_DUP2
  API: Fix clone.h
  API: Add tst_clone
  close_range: Add test

 include/lapi/clone.h                          |   5 +-
 include/lapi/syscalls/aarch64.in              |   1 +
 include/lapi/syscalls/arc.in                  |   1 +
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/hppa.in                 |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/ia64.in                 |   1 +
 include/lapi/syscalls/mips_n32.in             |   1 +
 include/lapi/syscalls/mips_n64.in             |   1 +
 include/lapi/syscalls/mips_o32.in             |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/s390x.in                |   1 +
 include/lapi/syscalls/sh.in                   |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 include/tst_clone.h                           |  28 +++
 include/tst_safe_macros.h                     |   5 +
 include/tst_test.h                            |   2 +-
 lib/tst_clone.c                               |  46 ++++
 lib/tst_safe_macros.c                         |  18 ++
 lib/tst_test.c                                |  25 +++
 .../kernel/syscalls/close_range/.gitignore    |   1 +
 .../kernel/syscalls/close_range/Makefile      |  10 +
 .../syscalls/close_range/close_range01.c      | 208 ++++++++++++++++++
 27 files changed, 362 insertions(+), 3 deletions(-)
 create mode 100644 lib/tst_clone.c
 create mode 100644 testcases/kernel/syscalls/close_range/.gitignore
 create mode 100644 testcases/kernel/syscalls/close_range/Makefile
 create mode 100644 testcases/kernel/syscalls/close_range/close_range01.c

-- 
2.30.0

