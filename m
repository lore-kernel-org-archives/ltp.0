From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:14 +0300
Subject: [LTP] [PATCH v2 00/16] syscalls/sched_*: convert to new API and
 handle ENOSYS errno
Message-ID: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The patch-set adds new libc/sys_sched_* wrappers to test libc
and syscall variants of sched_*() functions seperately.

This is needed because musl libc returns ENOSYS for those
functions [1], and the tests just fails with it.

[1]: https://git.musl-libc.org/cgit/musl/commit/?id=1e21e78bf7a5

v2: Using test variants

Alexey Kodanev (16):
  lib/tst_sched: add ltp sys/libc_sched_*() wrappers
  syscalls/sched_getparam01: use libc/sys_sched_*()
  syscalls/sched_getparam03: use libc/sys_sched_*()
  syscalls/sched_setparam01: convert to new API
  syscalls/sched_setparam02: convert to new API
  syscalls/sched_setparam03: convert to new API
  syscalls/sched_setparam04: convert to new API
  syscalls/sched_setparam05: convert to new API
  syscalls/sched_rr_get_interval01: use sys_sched_*()
  syscalls/sched_rr_get_interval02: use sys_sched_*()
  syscalls/sched_rr_get_interval03: use sys_sched_*()
  syscalls/sched_setscheduler01: convert to new API
  syscalls/sched_setscheduler02: convert to new API
  syscalls/sched_setscheduler03: use libc/sys_sched_*()
  syscalls/sched_getscheduler01: convert to new API
  syscalls/sched_getscheduler02: convert to new API

 include/tst_sched.h                           |  70 ++++++
 .../sched_getparam/sched_getparam01.c         |  17 +-
 .../sched_getparam/sched_getparam03.c         |  13 +-
 .../sched_getscheduler/sched_getscheduler01.c | 154 ++++--------
 .../sched_getscheduler/sched_getscheduler02.c | 109 ++------
 .../sched_rr_get_interval01.c                 |   4 +-
 .../sched_rr_get_interval02.c                 |   4 +-
 .../sched_rr_get_interval03.c                 |   4 +-
 .../sched_setparam/sched_setparam01.c         | 140 ++---------
 .../sched_setparam/sched_setparam02.c         | 207 ++++-----------
 .../sched_setparam/sched_setparam03.c         | 235 +++++-------------
 .../sched_setparam/sched_setparam04.c         | 167 +++----------
 .../sched_setparam/sched_setparam05.c         | 192 +++-----------
 .../sched_setscheduler/sched_setscheduler01.c | 180 ++++----------
 .../sched_setscheduler/sched_setscheduler02.c | 165 ++++--------
 .../sched_setscheduler/sched_setscheduler03.c |  39 +--
 16 files changed, 504 insertions(+), 1196 deletions(-)
 create mode 100644 include/tst_sched.h

-- 
2.25.1

