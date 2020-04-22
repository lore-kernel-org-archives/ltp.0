From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 22 Apr 2020 11:07:21 +0530
Subject: [LTP] [PATCH V4 0/5] syscalls/clock_*(): Add support for time64
 variants
Message-ID: <cover.1587533697.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Here is the fourth version of this series and here are the changes since
v3.

V3->V4:
- Dropped the first patch, it is already applied by Cyril.
- Update clock_gettime() patch (1/5), according to the changes Cyril
  made.
- Rest four patches (2-5/5) are posted for the first time here.

--
Viresh

Viresh Kumar (5):
  syscalls/clock_gettime: Add support for time64 tests
  syscalls/clock_settime: Add support for time64 tests
  syscalls/clock_getres: Add support for time64 tests
  syscalls/clock_nanosleep: Add support for time64 tests
  syscalls/clock_adjtime: Add support for time64 tests

 include/tst_timer.h                           | 122 +++++++++-
 runtest/syscalls                              |   2 +-
 .../syscalls/clock_adjtime/clock_adjtime.h    | 220 +++++++++++++++---
 .../syscalls/clock_adjtime/clock_adjtime01.c  | 124 ++++++----
 .../syscalls/clock_adjtime/clock_adjtime02.c  |  90 +++++--
 .../syscalls/clock_getres/clock_getres01.c    |  58 +++--
 .../syscalls/clock_gettime/clock_gettime01.c  | 116 +++++----
 .../syscalls/clock_gettime/clock_gettime02.c  |  72 +++---
 .../syscalls/clock_gettime/clock_gettime03.c  |  58 ++++-
 .../syscalls/clock_nanosleep/.gitignore       |   1 +
 .../clock_nanosleep/clock_nanosleep01.c       | 102 ++++++--
 .../clock_nanosleep/clock_nanosleep03.c       |  68 +++++-
 .../clock_nanosleep/clock_nanosleep04.c       |  90 +++++++
 .../syscalls/clock_nanosleep2/.gitignore      |   1 -
 .../kernel/syscalls/clock_nanosleep2/Makefile |  10 -
 .../clock_nanosleep2/clock_nanosleep2_01.c    |  45 ----
 .../syscalls/clock_settime/clock_settime01.c  |  87 +++++--
 .../syscalls/clock_settime/clock_settime02.c  |  95 +++++---
 18 files changed, 993 insertions(+), 368 deletions(-)
 create mode 100644 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep04.c
 delete mode 100644 testcases/kernel/syscalls/clock_nanosleep2/.gitignore
 delete mode 100644 testcases/kernel/syscalls/clock_nanosleep2/Makefile
 delete mode 100644 testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c

-- 
2.25.0.rc1.19.g042ed3e048af

