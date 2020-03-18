From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Mar 2020 16:37:52 +0100
Subject: [LTP] [PATCH v2 0/9] Add basic time namespace testcases
Message-ID: <20200318153801.3529-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a set of test for the time namespaces that are going to be part
of 5.6 kernel.

v2:

* Added git has into sysinfo03, as requested by ritchie

* Included description for the timens01 test as requsted by ritchie

* Added SAFE_NETNS() which fixed compilation problems reported by pvorel
  as well

Cyril Hrubis (9):
  lapi/namespace_constants.h: Add CLONE_NEWTIME
  lapi: Add a configure check and fallback for setns
  safe_macros: Add SAFE_SETNS()
  include/tst_timer: Fix normalization
  syscalls/sysinfo03: Add time namespace test
  syscalls/clock_nanosleep03: Add test for time namespace
  syscalls/clock_gettime03: Add basic time namespace test
  containers/timens: Add basic error test
  syscalls/timerfd04: Add time namespace test

 configure.ac                                  |   1 +
 include/lapi/namespaces_constants.h           |   3 +
 include/lapi/setns.h                          |  20 ++++
 include/tst_safe_macros.h                     |   4 +
 include/tst_timer.h                           |  35 +++---
 lib/tst_safe_macros.c                         |  12 ++
 runtest/containers                            |   7 ++
 runtest/syscalls                              |   4 +
 testcases/kernel/containers/timens/.gitignore |   1 +
 testcases/kernel/containers/timens/Makefile   |   6 +
 testcases/kernel/containers/timens/timens01.c |  68 +++++++++++
 .../kernel/syscalls/clock_gettime/.gitignore  |   1 +
 .../syscalls/clock_gettime/clock_gettime03.c  | 112 ++++++++++++++++++
 .../syscalls/clock_nanosleep/.gitignore       |   1 +
 .../clock_nanosleep/clock_nanosleep03.c       |  71 +++++++++++
 testcases/kernel/syscalls/sysinfo/.gitignore  |   1 +
 testcases/kernel/syscalls/sysinfo/sysinfo03.c |  81 +++++++++++++
 testcases/kernel/syscalls/timerfd/.gitignore  |   1 +
 testcases/kernel/syscalls/timerfd/timerfd04.c |  98 +++++++++++++++
 19 files changed, 510 insertions(+), 17 deletions(-)
 create mode 100644 include/lapi/setns.h
 create mode 100644 testcases/kernel/containers/timens/.gitignore
 create mode 100644 testcases/kernel/containers/timens/Makefile
 create mode 100644 testcases/kernel/containers/timens/timens01.c
 create mode 100644 testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
 create mode 100644 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
 create mode 100644 testcases/kernel/syscalls/sysinfo/sysinfo03.c
 create mode 100644 testcases/kernel/syscalls/timerfd/timerfd04.c

-- 
2.24.1

