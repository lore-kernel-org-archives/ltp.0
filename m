From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 Mar 2019 04:23:25 +0100
Subject: [LTP] [PATCH 0/5] Some MUSL fixes
Message-ID: <20190318032330.3346-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

there are numerous problems with LTP build with MUSL.
This patchset address only few obvious ones.

Kind regards,
Petr

Petr Vorel (5):
  rt_sigaction.h: Check for type sighandler_t and use if present
  {rt_,}sigaction: Define _GNU_SOURCE to get SA_NOMASK on MUSL
  ptrace: Use int instead of enum  __ptrace_request
  mremap: Define _GNU_SOURCE to get MREMAP_MAYMOVE on MUSL
  mallopt: Test only on glibc

 include/lapi/rt_sigaction.h                             | 8 ++++++++
 m4/ltp-sighandler_t.m4                                  | 8 ++++++++
 testcases/kernel/syscalls/mallopt/mallopt01.c           | 6 +++---
 testcases/kernel/syscalls/mremap/mremap01.c             | 4 ++--
 testcases/kernel/syscalls/mremap/mremap02.c             | 3 +--
 testcases/kernel/syscalls/mremap/mremap03.c             | 3 +--
 testcases/kernel/syscalls/mremap/mremap04.c             | 3 +--
 testcases/kernel/syscalls/ptrace/ptrace03.c             | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace06.c             | 2 +-
 testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h   | 2 +-
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c | 1 +
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c | 1 +
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c | 1 +
 testcases/kernel/syscalls/sigaction/sigaction02.c       | 2 ++
 testcases/misc/crash/crash01.c                          | 1 +
 15 files changed, 33 insertions(+), 14 deletions(-)
 create mode 100644 m4/ltp-sighandler_t.m4

-- 
2.20.1

