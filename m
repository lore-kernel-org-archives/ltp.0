From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:22 +0200
Subject: [LTP] [RFC PATCH 0/9] Rewrite msgctl testcases
Message-ID: <20180612154631.435-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Cyril Hrubis (9):
  tst_safe_sysv_ipc: Make safe_shmctl() and safe_msgctl() safer
  tst_safe_sysv_ipc: SAFE_{SHMCTL,MSGCTL} return retval
  syscalls/ipc: Rewrite msgctl01 + merge msgctl06
  syscalls/ipc: Rewrite msgctl02 to new library.
  syscalls/ipc: Convert to newlib and merge msgctl{13,03}
  syscalls/ipc: Rewrite + merge msgctl{04, 05}
  syscalls/ipc: Rewrite msgctl12 to new library
  syscalls/ipc: Remove msgctl07
  syscalls/ipc: Fix Makefile

 include/tst_safe_sysv_ipc.h                     |  12 +-
 lib/tst_safe_sysv_ipc.c                         |  33 ++-
 runtest/ltplite                                 |   3 -
 runtest/stress.part3                            |   3 -
 runtest/syscalls                                |   4 -
 runtest/syscalls-ipc                            |   4 -
 testcases/kernel/syscalls/ipc/msgctl/.gitignore |   4 -
 testcases/kernel/syscalls/ipc/msgctl/Makefile   |   8 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl01.c | 242 ++++++++++----------
 testcases/kernel/syscalls/ipc/msgctl/msgctl02.c | 207 +++++------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl03.c | 159 +++----------
 testcases/kernel/syscalls/ipc/msgctl/msgctl04.c | 249 +++++++-------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c | 186 ---------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c | 142 ------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl07.c | 292 ------------------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl12.c |  84 +++----
 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c |  86 -------
 17 files changed, 360 insertions(+), 1358 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c

-- 
2.13.6

