From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:08 +0300
Subject: [LTP] [PATCH 00/16] syscalls/sched_*: convert to new API and handle
 ENOSYS errno
Message-ID: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The patch-set introduced new tst_sched_* wrappers to handle ENOSYS
error that can be returned by libc (musl [1]). In that particular
case the wrapper uses syscall directly to test the kernel anyway.

[1]: https://git.musl-libc.org/cgit/musl/commit/?id=1e21e78bf7a5

Alexey Kodanev (16):
  lib/tst_sched: add ltp tst_sched_*()
  syscalls/sched_getparam01: use tst_sched_*()
  syscalls/sched_getparam03: use tst_sched_*()
  syscalls/sched_setparam01: convert to new API
  syscalls/sched_setparam02: convert to new API
  syscalls/sched_setparam03: convert to new API
  syscalls/sched_setparam04: convert to new API
  syscalls/sched_setparam05: convert to new API
  syscalls/sched_rr_get_interval01: use tst_sched_*()
  syscalls/sched_rr_get_interval02: use tst_sched_*()
  syscalls/sched_rr_get_interval03: use tst_sched_*()
  syscalls/sched_setscheduler01: convert to new API
  syscalls/sched_setscheduler02: convert to new API
  syscalls/sched_setscheduler03: use tst_sched_*()
  syscalls/sched_getscheduler01: convert to new API
  syscalls/sched_getscheduler02: convert to new API

 include/tst_sched.h                           |  16 ++
 lib/tst_sched.c                               |  36 +++
 .../sched_getparam/sched_getparam01.c         |   6 +-
 .../sched_getparam/sched_getparam03.c         |   4 +-
 .../sched_getscheduler/sched_getscheduler01.c | 141 +++---------
 .../sched_getscheduler/sched_getscheduler02.c | 104 ++-------
 .../sched_rr_get_interval01.c                 |   4 +-
 .../sched_rr_get_interval02.c                 |   4 +-
 .../sched_rr_get_interval03.c                 |   4 +-
 .../sched_setparam/sched_setparam01.c         | 135 ++---------
 .../sched_setparam/sched_setparam02.c         | 195 +++-------------
 .../sched_setparam/sched_setparam03.c         | 215 ++++--------------
 .../sched_setparam/sched_setparam04.c         | 161 +++----------
 .../sched_setparam/sched_setparam05.c         | 186 +++------------
 .../sched_setscheduler/sched_setscheduler01.c | 171 ++++----------
 .../sched_setscheduler/sched_setscheduler02.c | 154 +++----------
 .../sched_setscheduler/sched_setscheduler03.c |  10 +-
 17 files changed, 345 insertions(+), 1201 deletions(-)
 create mode 100644 include/tst_sched.h
 create mode 100644 lib/tst_sched.c

-- 
2.25.1

