From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:13 +0530
Subject: [LTP] [PATCH 00/16] syscalls: Use common variants structure
Message-ID: <cover.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

As you suggested earlier, here is an attempt to use a common structure
prototype at most of the places.

futex, clock_adjtime() and clock_getres() tests are left with their own
implementations due to compatibility issues.

--
viresh

Viresh Kumar (16):
  syscalls: Add common time64 variants structure
  syscalls: clock_gettime: Reuse struct time64_variants
  syscalls: clock_nanosleep: Reuse struct time64_variants
  syscalls: clock_settime: Reuse struct time64_variants
  syscalls: io_pgetevents: Reuse struct time64_variants
  syscalls: semop: Reuse struct time64_variants
  syscalls: mq_timed: Reuse struct time64_variants
  syscalls: ppoll: Reuse struct time64_variants
  syscalls: rt_sigtimedwait: Reuse struct time64_variants
  syscalls: sched_rr_get_interval: Reuse struct time64_variants
  syscalls: sendmmsg: Reuse struct time64_variants
  syscalls: timer_settime: Reuse struct time64_variants
  syscalls: timer_gettime: Reuse struct time64_variants
  syscalls: timerfd: Reuse struct time64_variants
  syscalls: utimensat: Reuse struct time64_variants
  futex: Move variants struct definition to common header

 include/time64_variants.h                     | 56 +++++++++++++++++++
 .../syscalls/clock_gettime/clock_gettime01.c  | 19 +++----
 .../syscalls/clock_gettime/clock_gettime02.c  | 17 +++---
 .../syscalls/clock_gettime/clock_gettime03.c  | 27 ++++-----
 .../syscalls/clock_gettime/clock_gettime04.c  | 29 +++++-----
 .../clock_nanosleep/clock_nanosleep01.c       | 21 +++----
 .../clock_nanosleep/clock_nanosleep03.c       | 26 ++++-----
 .../clock_nanosleep/clock_nanosleep04.c       | 22 +++-----
 .../syscalls/clock_settime/clock_settime01.c  | 26 ++++-----
 .../syscalls/clock_settime/clock_settime02.c  | 20 +++----
 .../syscalls/clock_settime/clock_settime03.c  | 22 +++-----
 .../syscalls/futex/futex_cmp_requeue01.c      | 12 ++--
 .../syscalls/futex/futex_cmp_requeue02.c      |  9 +--
 .../kernel/syscalls/futex/futex_wait01.c      | 10 +---
 .../kernel/syscalls/futex/futex_wait02.c      | 11 ++--
 .../kernel/syscalls/futex/futex_wait03.c      | 11 ++--
 .../kernel/syscalls/futex/futex_wait04.c      | 10 +---
 .../syscalls/futex/futex_wait_bitset01.c      | 11 +---
 .../kernel/syscalls/futex/futex_wake01.c      |  9 +--
 .../kernel/syscalls/futex/futex_wake02.c      | 11 ++--
 .../kernel/syscalls/futex/futex_wake03.c      | 13 ++---
 .../kernel/syscalls/futex/futex_wake04.c      | 14 ++---
 testcases/kernel/syscalls/futex/futextest.h   |  7 +++
 .../syscalls/io_pgetevents/io_pgetevents01.c  | 16 ++----
 .../syscalls/io_pgetevents/io_pgetevents02.c  | 18 +++---
 testcases/kernel/syscalls/ipc/semop/semop.h   | 18 +++---
 testcases/kernel/syscalls/ipc/semop/semop01.c |  6 +-
 testcases/kernel/syscalls/ipc/semop/semop02.c |  6 +-
 testcases/kernel/syscalls/ipc/semop/semop03.c |  6 +-
 .../mq_timedreceive/mq_timedreceive01.c       | 14 ++---
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 16 +++---
 testcases/kernel/syscalls/ppoll/ppoll01.c     | 21 +++----
 .../rt_sigtimedwait/rt_sigtimedwait01.c       | 15 ++---
 .../sched_rr_get_interval01.c                 | 21 +++----
 .../sched_rr_get_interval02.c                 | 21 +++----
 .../sched_rr_get_interval03.c                 | 21 +++----
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 24 +++-----
 .../syscalls/timer_gettime/timer_gettime01.c  | 21 +++----
 .../syscalls/timer_settime/timer_settime01.c  | 25 ++++-----
 .../syscalls/timer_settime/timer_settime02.c  | 18 +++---
 testcases/kernel/syscalls/timerfd/timerfd01.c | 27 ++++-----
 testcases/kernel/syscalls/timerfd/timerfd04.c | 20 +++----
 .../syscalls/timerfd/timerfd_gettime01.c      |  8 +--
 .../syscalls/timerfd/timerfd_settime01.c      | 17 +++---
 .../syscalls/timerfd/timerfd_settime02.c      | 15 ++---
 testcases/kernel/syscalls/utils/mq_timed.h    | 18 ++----
 .../kernel/syscalls/utimensat/utimensat01.c   | 18 +++---
 47 files changed, 367 insertions(+), 456 deletions(-)
 create mode 100644 include/time64_variants.h

-- 
2.25.0.rc1.19.g042ed3e048af

