From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 14 Apr 2020 16:30:37 +0530
Subject: [LTP] [PATCH V2 0/2] syscalls/clock_gettime: Add support for time64
 tests
Message-ID: <cover.1586861885.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

The first version was sent as an RFC to understand how we should go
about it and here is the first version that can be merged. There are
too many changes to be described here, very much different than the RFC.

--
viresh

Viresh Kumar (2):
  tst_timer: Add time64 related helpers
  syscalls/clock_gettime: Add support for time64 tests

 include/tst_timer.h                           | 379 ++++++++++--------
 .../syscalls/clock_gettime/clock_gettime.h    |  29 ++
 .../syscalls/clock_gettime/clock_gettime01.c  | 125 +++---
 .../syscalls/clock_gettime/clock_gettime02.c  |  80 ++--
 .../syscalls/clock_gettime/clock_gettime03.c  |  80 +++-
 5 files changed, 425 insertions(+), 268 deletions(-)
 create mode 100644 testcases/kernel/syscalls/clock_gettime/clock_gettime.h

-- 
2.21.0.rc0.269.g1a574e7a288b

