From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 13 Apr 2021 08:07:46 +0100
Subject: [LTP] [PATCH v4 0/7] Fuzzy Sync single core support and tests
Message-ID: <20210413070753.1691-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

V4: (no change in logic)
* Remove useless variable in pair_init
* Explain TIME_SCALE
* Differentiate between "cs" variables when printing
* Add reviewed by trailers

V3:
* Add -pthread to test CFLAGS
* Substitute CPU_COUNT for CPU_COUNT_S and check for alloc failure

V2:
* Add tst_ncpus_available() to API
* Don't use CHK macro for yield_in_wait to prevent compiler warnings
* Simplify and split the test in two

I'm reasonably confident of the first tests correctness. The second is
maybe not complete and more formal analyses is needed IMO. I suspect
also that we can remove add_delay_bias and implement randomised
probing instead. The more I think about it the more clear it becomes,
but it may require some bigger changes to how we calculate and
introduce the delays.

Occasionally some tests may not reach the lower threshold and fail. It
may be caused by changes in the environment between the measuring and
delay implementation phases. This is also something which could be
investigated.

Anyway this is all still very time consuming and making it perform
well on single core is most important right now.

Leo Yu-Chi Liang (1):
  fzsync: Add sched_yield for single core machine

Richard Palethorpe (6):
  fzsync: Add self tests
  fzsync: Reset delay bias
  fzsync: Correctly print positive lower delay range bound
  fzsync: Move yield check out of loop and add yield to delay
  API: Add tst_ncpus_available
  fzsync: Check processor affinity

 include/tst_cpu.h                   |   1 +
 include/tst_fuzzy_sync.h            | 104 +++++++++---
 lib/newlib_tests/.gitignore         |   2 +
 lib/newlib_tests/Makefile           |   2 +
 lib/newlib_tests/test16.c           |   2 +
 lib/newlib_tests/tst_fuzzy_sync01.c | 235 ++++++++++++++++++++++++++++
 lib/newlib_tests/tst_fuzzy_sync02.c | 177 +++++++++++++++++++++
 lib/tst_cpu.c                       |  26 +++
 8 files changed, 525 insertions(+), 24 deletions(-)
 create mode 100644 lib/newlib_tests/tst_fuzzy_sync01.c
 create mode 100644 lib/newlib_tests/tst_fuzzy_sync02.c

-- 
2.30.2

