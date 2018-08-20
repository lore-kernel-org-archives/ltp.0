From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 20 Aug 2018 08:42:52 +0200
Subject: [LTP] [PATCH 0/5] Convert tst_timer.h to newlib
Message-ID: <20180820064257.17974-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

In order to allow tst_timer.h to be used with new library functions, it needs
to be converted to the new library. This will help extend tst_timer for
tst_fuzzy_sync.

Richard Palethorpe (5):
  Convert nanosleep02 to newlib
  lib: Add LTP_ATTRIBUTE_FALLTHROUGH for case statements
  Convert fcntl33 to newlib
  Convert futex_wait_bitset tests to newlib
  tst_timer: Convert to new library

 include/old/test.h                            |   1 -
 include/tst_common.h                          |   1 +
 lib/tst_timer.c                               |  14 +-
 testcases/kernel/syscalls/fcntl/fcntl33.c     | 168 ++++++++----------
 .../kernel/syscalls/futex/futex_wait_bitset.h |  54 ++++--
 .../syscalls/futex/futex_wait_bitset01.c      |  22 +--
 .../syscalls/futex/futex_wait_bitset02.c      |  23 +--
 .../kernel/syscalls/nanosleep/nanosleep02.c   | 123 +++++--------
 8 files changed, 163 insertions(+), 243 deletions(-)

-- 
2.18.0

