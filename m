From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:24:06 +0530
Subject: [LTP] [PATCH V2 0/6] syscalls: Remove incorrect usage of libc
 structures
Message-ID: <cover.1590130423.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

It is incorrect to use the libc structures (timespec, timeval, timex),
to the non-time64 syscalls called via tst_syscall() as the kernel
expects the old structures in there and the libc structure definition
may change in the future.

V2:
- Use .restore_wallclock flag and remove unnecessary restoration code.
- Update tst_clock_*() syscall's implementation instead of its users.

Viresh Kumar (6):
  tst_safe_clocks: Remove safe_clock_adjtime()
  syscalls: settimeofday01: Set .restore_wallclock flag
  syscalls: settimeofday02: Remove time restoration code
  syscalls: settimeofday: Use gettimeofday()
  syscalls: Don't pass struct timespec to tst_syscall()
  syscalls: Don't pass struct timeval to tst_syscall()

 include/tst_safe_clocks.h                     | 18 ------
 include/tst_timer.h                           |  6 ++
 lib/tst_clocks.c                              | 59 ++++++++++++++++++-
 .../syscalls/clock_adjtime/clock_adjtime.h    |  5 --
 .../syscalls/gettimeofday/gettimeofday02.c    |  3 +-
 .../syscalls/settimeofday/settimeofday01.c    | 21 +------
 .../syscalls/settimeofday/settimeofday02.c    | 21 -------
 testcases/kernel/syscalls/stime/stime_var.h   |  3 +-
 8 files changed, 69 insertions(+), 67 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

