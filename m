From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Jul 2020 14:15:05 +0200
Subject: [LTP] [PATCH 0/3] Build system fixes
Message-ID: <20200731121508.12805-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset does

* Introduce LTPLDLIBS to solve linker dependencies once for all

* Cleans up the output from make a bit, this could be even more fine
  tuned if we agree on this part

Cyril Hrubis (3):
  build system: Add explicit make rules
  testcases: Make use of LTPLDLIBS
  build system: Silence the output a bit more

 include/mk/env_post.mk                        |  2 ++
 include/mk/generic_trunk_target.inc           | 14 +++++++++
 include/mk/lib.mk                             |  2 +-
 include/mk/rules.mk                           | 29 +++++++++++++++++++
 include/mk/testcases.mk                       |  5 ++++
 .../kernel/syscalls/clock_gettime/Makefile    |  2 +-
 testcases/kernel/syscalls/ipc/msgctl/Makefile |  2 +-
 testcases/kernel/syscalls/ipc/msgget/Makefile |  2 +-
 testcases/kernel/syscalls/ipc/msgrcv/Makefile |  2 +-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile |  2 +-
 .../kernel/syscalls/ipc/msgstress/Makefile    |  2 +-
 testcases/kernel/syscalls/ipc/semctl/Makefile |  4 +--
 testcases/kernel/syscalls/ipc/semget/Makefile |  2 +-
 testcases/kernel/syscalls/ipc/semop/Makefile  |  2 +-
 testcases/kernel/syscalls/ipc/shmat/Makefile  |  2 +-
 testcases/kernel/syscalls/ipc/shmctl/Makefile |  4 +--
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |  2 +-
 testcases/kernel/syscalls/ipc/shmget/Makefile |  2 +-
 testcases/kernel/syscalls/kill/Makefile       |  4 +--
 testcases/kernel/syscalls/mbind/Makefile      |  6 ++--
 testcases/kernel/syscalls/mremap/Makefile     |  2 +-
 .../kernel/syscalls/rt_sigtimedwait/Makefile  |  2 +-
 .../kernel/syscalls/set_mempolicy/Makefile    |  3 +-
 .../kernel/syscalls/sigtimedwait/Makefile     |  2 +-
 testcases/kernel/syscalls/sigwait/Makefile    |  2 +-
 .../kernel/syscalls/sigwaitinfo/Makefile      |  2 +-
 26 files changed, 79 insertions(+), 26 deletions(-)
 create mode 100644 include/mk/rules.mk

-- 
2.26.2

