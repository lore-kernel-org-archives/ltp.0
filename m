From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  8 May 2020 09:53:45 +0530
Subject: [LTP] [PATCH V2 00/17] Syscalls: Add support for time64 variants
Message-ID: <cover.1588911607.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril/Petr,

This replaces all my pending patches that I have sent earlier and not
applied yet. I am sending them all together (along with few new patches)
to avoid any rebase conflicts as reported by Petr.

I have also fixed the GPL licensing thing that Petr asked for at several
files in this V2. Otherwise no difference in the patches.

With this I have completed the time64 support for all the syscalls
tests.

Viresh Kumar (17):
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

 include/lapi/io_pgetevents.h                  |  15 +-
 include/tst_timer.h                           | 191 +++++++
 runtest/syscalls                              |   1 -
 testcases/kernel/syscalls/futex/.gitignore    |   1 -
 testcases/kernel/syscalls/futex/Makefile      |   1 -
 .../syscalls/futex/futex_cmp_requeue01.c      |  35 +-
 .../syscalls/futex/futex_cmp_requeue02.c      |  25 +-
 testcases/kernel/syscalls/futex/futex_utils.h |  52 +-
 .../kernel/syscalls/futex/futex_wait01.c      |  83 +--
 .../kernel/syscalls/futex/futex_wait02.c      | 104 ++--
 .../kernel/syscalls/futex/futex_wait03.c      |  91 +--
 .../kernel/syscalls/futex/futex_wait04.c      |  85 +--
 .../kernel/syscalls/futex/futex_wait05.c      |   2 +-
 .../kernel/syscalls/futex/futex_wait_bitset.h |  75 ---
 .../syscalls/futex/futex_wait_bitset01.c      | 103 +++-
 .../syscalls/futex/futex_wait_bitset02.c      |  18 -
 .../kernel/syscalls/futex/futex_wake01.c      |  71 ++-
 .../kernel/syscalls/futex/futex_wake02.c      |  99 ++--
 .../kernel/syscalls/futex/futex_wake03.c      | 111 ++--
 .../kernel/syscalls/futex/futex_wake04.c      | 150 ++---
 testcases/kernel/syscalls/futex/futextest.h   | 111 ++--
 .../syscalls/io_pgetevents/io_pgetevents01.c  |  41 +-
 .../syscalls/io_pgetevents/io_pgetevents02.c  |  59 +-
 testcases/kernel/syscalls/ipc/semop/Makefile  |   2 +-
 testcases/kernel/syscalls/ipc/semop/semop.h   |  52 ++
 testcases/kernel/syscalls/ipc/semop/semop01.c | 145 +++--
 testcases/kernel/syscalls/ipc/semop/semop02.c | 153 +++---
 testcases/kernel/syscalls/ipc/semop/semop03.c | 160 ++----
 testcases/kernel/syscalls/ipc/semop/semop04.c | 173 +++---
 testcases/kernel/syscalls/ipc/semop/semop05.c | 309 +++++------
 .../mq_timedreceive/mq_timedreceive01.c       |  97 +++-
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 101 ++--
 testcases/kernel/syscalls/ppoll/ppoll01.c     |  76 ++-
 .../sched_rr_get_interval01.c                 | 131 ++---
 .../sched_rr_get_interval02.c                 | 137 ++---
 .../sched_rr_get_interval03.c                 | 151 +++--
 testcases/kernel/syscalls/select/select_var.h |  27 +-
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  45 +-
 .../kernel/syscalls/sendmmsg/sendmmsg_var.h   |  55 +-
 .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 317 ++++++-----
 .../syscalls/timer_gettime/timer_gettime01.c  | 135 ++---
 .../syscalls/timer_settime/timer_settime01.c  |  51 +-
 .../syscalls/timer_settime/timer_settime02.c  |  65 ++-
 testcases/kernel/syscalls/timerfd/timerfd01.c |  58 +-
 testcases/kernel/syscalls/timerfd/timerfd04.c |  56 +-
 .../syscalls/timerfd/timerfd_gettime01.c      | 138 +++--
 .../syscalls/timerfd/timerfd_settime01.c      | 139 +++--
 .../syscalls/timerfd/timerfd_settime02.c      |  33 +-
 testcases/kernel/syscalls/utils/mq_timed.h    |  42 +-
 .../kernel/syscalls/utimensat/utimensat01.c   | 469 ++++++++--------
 .../syscalls/utimensat/utimensat_tests.sh     | 517 ------------------
 51 files changed, 2657 insertions(+), 2701 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/futex/futex_wait_bitset.h
 delete mode 100644 testcases/kernel/syscalls/futex/futex_wait_bitset02.c
 create mode 100644 testcases/kernel/syscalls/ipc/semop/semop.h
 delete mode 100755 testcases/kernel/syscalls/utimensat/utimensat_tests.sh

-- 
2.25.0.rc1.19.g042ed3e048af

