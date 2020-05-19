From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:21:07 +0530
Subject: [LTP] [PATCH 0/5] syscalls: Remove incorrect usage of libc
 structures
Message-ID: <cover.1589877853.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

It is incorrect to use the libc structures (timespec, timeval, timex),
to the non-timex64 syscalls called via tst_syscall() as the kernel
expects the old structures in there and the libc structure definition
may change in the future.

Arnd: It was getting difficult to search for such instances and so I
searched it with following strings (search for files that use these
structures, as well as tst_syscall()) to catch the abuse, hope it covers
all cases.

git grep "struct timeval" `git grep -l tst_syscall`
git grep "struct timespec" `git grep -l tst_syscall`
git grep "struct timex" `git grep -l tst_syscall`

Viresh Kumar (5):
  tst_safe_clocks: Remove safe_clock_adjtime()
  syscalls: settimeofday: Use gettimeofday()
  syscalls: Don't use tst_syscall() unnecessarily
  syscalls: Don't pass struct timespec to tst_syscall()
  syscalls: Don't pass struct timeval to tst_syscall()

 include/tst_clocks.h                          |  8 ++++---
 include/tst_safe_clocks.h                     | 18 ---------------
 include/tst_timer.h                           |  6 +++++
 lib/parse_opts.c                              |  3 +--
 lib/tst_clocks.c                              |  6 ++---
 lib/tst_test.c                                | 16 ++++++-------
 lib/tst_timer.c                               | 23 ++++++++++++-------
 lib/tst_timer_test.c                          |  2 +-
 lib/tst_wallclock.c                           | 17 +++++++-------
 testcases/cve/cve-2016-7117.c                 |  2 +-
 .../syscalls/clock_adjtime/clock_adjtime.h    |  5 ----
 .../syscalls/gettimeofday/gettimeofday02.c    |  3 ++-
 .../syscalls/settimeofday/settimeofday01.c    |  6 ++---
 .../syscalls/settimeofday/settimeofday02.c    |  2 +-
 testcases/kernel/syscalls/stime/stime_var.h   |  3 ++-
 15 files changed, 57 insertions(+), 63 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

