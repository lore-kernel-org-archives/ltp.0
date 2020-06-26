From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:13 +0530
Subject: [LTP] [PATCH V7 00/19] Syscalls: Add support for time64 variants
Message-ID: <cover.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This updates the pending syscall tests that lacked the time64 updates.

V7:
- Move all tst_timer.h changes to a single patch.
- Provide more generic helpers for itimerspec and update the patches
  accordingly.
- Also include the y2038 patch in the series as that depends on the
  first patch here.

V6: Drop the binary files included by mistake.
V5: Use __kernel_old_itimerspec instead of __kernel_itimerspec.
V4:
- Pass timer_t type to timer_gettime/settime syscalls instead of
  kernel_timer_t.
- Some part of timer_settime() patch was merged in timerfd_gettime()
  earlier by mistake, fixed that.

V3:
- Fix issues related to passing incorrect timespec type to syscalls.
- Take care of futex and semtimedop tests where the architecture
  provides the syscall number, but doesn't implement it.
- Other improvements and cleanups.

Viresh Kumar (19):
  tst_timer: Add new definitions
  syscalls/timer_gettime: Add support for time64 tests
  syscalls/timer_settime: Add support for time64 tests
  syscalls/timerfd: Add support for time64 tests
  syscalls/sched_rr_get_interval: Add support for time64 tests
  syscalls/futex: Merge futex_wait_bitset tests
  syscalls/futex: Add support for time64 tests
  syscalls/io_pgetevents: Add support for time64 tests
  syscalls/sigwaitinfo: Migrate to new test framework
  syscalls/rt_sigtimedwait: Add support for time64 tests
  syscalls/mq_timed{send|receive}: Add support for time64 tests
  syscalls/recvmmsg: Add support for time64 tests
  syscalls/ppoll: Add support for time64 tests
  syscalls/select6: Add support for time64 tests
  syscalls/semop: Migrate to new test framework
  syscalls/semtimedop: Add support for semtimedop and its time64 version
  syscalls/utimensat: Migrate to new test framework
  syscalls/utimensat: Add support for time64 tests
  syscalls: clock_settime: Add test around y2038 vulnerability

 include/lapi/io_pgetevents.h                  |  15 +-
 include/tst_timer.h                           | 326 ++++++++++-
 runtest/syscalls                              |   4 +-
 .../kernel/syscalls/clock_settime/.gitignore  |   1 +
 .../syscalls/clock_settime/clock_settime03.c  | 119 ++++
 testcases/kernel/syscalls/futex/.gitignore    |   1 -
 testcases/kernel/syscalls/futex/Makefile      |   1 -
 .../syscalls/futex/futex_cmp_requeue01.c      |  34 +-
 .../syscalls/futex/futex_cmp_requeue02.c      |  24 +-
 testcases/kernel/syscalls/futex/futex_utils.h |  52 +-
 .../kernel/syscalls/futex/futex_wait01.c      |  79 +--
 .../kernel/syscalls/futex/futex_wait02.c      | 102 ++--
 .../kernel/syscalls/futex/futex_wait03.c      |  87 ++-
 .../kernel/syscalls/futex/futex_wait04.c      |  81 +--
 .../kernel/syscalls/futex/futex_wait05.c      |   2 +-
 .../kernel/syscalls/futex/futex_wait_bitset.h |  75 ---
 .../syscalls/futex/futex_wait_bitset01.c      | 101 +++-
 .../syscalls/futex/futex_wait_bitset02.c      |  18 -
 .../kernel/syscalls/futex/futex_wake01.c      |  67 ++-
 .../kernel/syscalls/futex/futex_wake02.c      |  95 ++--
 .../kernel/syscalls/futex/futex_wake03.c      | 109 ++--
 .../kernel/syscalls/futex/futex_wake04.c      | 145 +++--
 testcases/kernel/syscalls/futex/futextest.h   | 122 +++--
 .../syscalls/io_pgetevents/io_pgetevents01.c  |  33 +-
 .../syscalls/io_pgetevents/io_pgetevents02.c  |  51 +-
 testcases/kernel/syscalls/ipc/semop/Makefile  |   4 +-
 testcases/kernel/syscalls/ipc/semop/semop.h   |  55 ++
 testcases/kernel/syscalls/ipc/semop/semop01.c | 148 +++--
 testcases/kernel/syscalls/ipc/semop/semop02.c | 156 +++---
 testcases/kernel/syscalls/ipc/semop/semop03.c | 162 +++---
 testcases/kernel/syscalls/ipc/semop/semop04.c | 177 +++---
 testcases/kernel/syscalls/ipc/semop/semop05.c | 313 +++++------
 .../mq_timedreceive/mq_timedreceive01.c       |  92 +++-
 .../syscalls/mq_timedsend/mq_timedsend01.c    |  96 ++--
 testcases/kernel/syscalls/ppoll/ppoll01.c     |  71 ++-
 .../sched_rr_get_interval01.c                 | 116 ++--
 .../sched_rr_get_interval02.c                 | 122 ++---
 .../sched_rr_get_interval03.c                 | 146 +++--
 testcases/kernel/syscalls/select/select_var.h |  25 +-
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  40 +-
 .../kernel/syscalls/sendmmsg/sendmmsg_var.h   |  55 +-
 .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 311 ++++++-----
 .../syscalls/timer_gettime/timer_gettime01.c  | 135 +++--
 .../syscalls/timer_settime/timer_settime01.c  |  51 +-
 .../syscalls/timer_settime/timer_settime02.c  |  69 ++-
 testcases/kernel/syscalls/timerfd/timerfd01.c |  56 +-
 testcases/kernel/syscalls/timerfd/timerfd04.c |  54 +-
 .../syscalls/timerfd/timerfd_gettime01.c      | 133 ++---
 .../syscalls/timerfd/timerfd_settime01.c      | 136 +++--
 .../syscalls/timerfd/timerfd_settime02.c      |  28 +-
 testcases/kernel/syscalls/utils/mq_timed.h    |  42 +-
 testcases/kernel/syscalls/utimensat/Makefile  |   4 -
 .../kernel/syscalls/utimensat/utimensat01.c   | 472 ++++++++--------
 .../syscalls/utimensat/utimensat_tests.sh     | 517 ------------------
 54 files changed, 2819 insertions(+), 2711 deletions(-)
 create mode 100644 testcases/kernel/syscalls/clock_settime/clock_settime03.c
 delete mode 100644 testcases/kernel/syscalls/futex/futex_wait_bitset.h
 delete mode 100644 testcases/kernel/syscalls/futex/futex_wait_bitset02.c
 create mode 100644 testcases/kernel/syscalls/ipc/semop/semop.h
 delete mode 100755 testcases/kernel/syscalls/utimensat/utimensat_tests.sh

-- 
2.25.0.rc1.19.g042ed3e048af

