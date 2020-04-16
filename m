From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 16 Apr 2020 16:12:29 +0530
Subject: [LTP] [PATCH V3 0/2] syscalls/clock_gettime: Add support for time64
 tests
Message-ID: <cover.1587033556.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Here is the third version which looks very different from the previous
one again :)

V2->V3:
- Define an enum for timespec type create struct tst_timespec and update
  all generic helpers to handle them.
- Update clock_gettime tests to use them.

Viresh Kumar (2):
  tst_timer: Add support for kernel's 64 bit timespec
  syscalls/clock_gettime: Add support for time64 tests

 include/tst_timer.h                                | 549 +++++++++++++++++----
 .../syscalls/clock_gettime/clock_gettime01.c       | 116 ++---
 .../syscalls/clock_gettime/clock_gettime02.c       |  72 +--
 .../syscalls/clock_gettime/clock_gettime03.c       |  55 ++-
 4 files changed, 602 insertions(+), 190 deletions(-)

-- 
2.7.4

