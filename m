From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 21 May 2020 16:17:31 +0530
Subject: [LTP] [PATCH 0/5] syscalls: Add tests to verify the _time_high
 fields
Message-ID: <cover.1590057824.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This patchset adds a new test to three syscalls to verify that the
extended fields, _time_high, are cleared by the kernel. This was
suggested by Arnd.

I did run them, but on a 64 bit machine. Please see if you can check
that they work properly on 32 bit machines, where we really want to test
them. This is rebased over ltp master.

Cyril, This conflicts a bit with my other time64 syscall tests, I will
rebase one of these, after you apply any of these first :)

Viresh Kumar (5):
  syscalls:ipc: Move libraries to libs/ director
  include: Add declaration of struct ipc64_perm
  syscalls: semctl: Add new test to verify the _time_high fields
  syscalls: shmctl: Add new test to verify the _time_high fields
  syscalls: msgctl: Add new test to verify the _time_high fields

 configure.ac                                  |   4 +
 include/ipcbuf.h                              |  45 +++
 .../syscalls/ipc/lib => include}/ipcmsg.h     |   0
 .../syscalls/ipc/lib => include}/ipcsem.h     |   0
 .../syscalls/ipc/lib => include}/ipcshm.h     |   0
 .../syscalls/ipc/lib => include}/libmsgctl.h  |   0
 .../ipc/libnewipc => include}/libnewipc.h     |   2 +
 include/msgbuf.h                              | 306 ++++++++++++++++++
 include/sembuf.h                              | 234 ++++++++++++++
 include/shmbuf.h                              | 273 ++++++++++++++++
 .../ipc/lib => libs/libltpipc}/Makefile       |   5 +-
 .../ipc/lib => libs/libltpipc}/libipc.c       |   0
 .../ipc/lib => libs/libltpipc}/libmsgctl.c    |   0
 .../libnewipc => libs/libltpnewipc}/Makefile  |   5 +-
 .../libltpnewipc}/libnewipc.c                 |   0
 runtest/syscalls                              |   3 +
 runtest/syscalls-ipc                          |   3 +
 testcases/kernel/syscalls/ipc/Makefile        |  22 --
 testcases/kernel/syscalls/ipc/Makefile.inc    |  28 --
 testcases/kernel/syscalls/ipc/Makefile2.inc   |  22 --
 .../kernel/syscalls/ipc/msgctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/msgctl/Makefile |   5 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl05 | Bin 0 -> 498784 bytes
 .../kernel/syscalls/ipc/msgctl/msgctl05.c     |  48 +++
 testcases/kernel/syscalls/ipc/msgget/Makefile |   5 +-
 testcases/kernel/syscalls/ipc/msgrcv/Makefile |   5 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     |   2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     |   2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv03.c     |   2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv04.c     |   2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv05.c     |   2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv06.c     |   2 +-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile |   5 +-
 .../kernel/syscalls/ipc/msgstress/Makefile    |   8 +-
 .../syscalls/ipc/msgstress/msgstress01.c      |   2 +-
 .../syscalls/ipc/msgstress/msgstress02.c      |   2 +-
 .../syscalls/ipc/msgstress/msgstress03.c      |   2 +-
 .../syscalls/ipc/msgstress/msgstress04.c      |   2 +-
 .../kernel/syscalls/ipc/semctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/semctl/Makefile |   8 +-
 .../kernel/syscalls/ipc/semctl/semctl02.c     |   2 +-
 .../kernel/syscalls/ipc/semctl/semctl03.c     |   2 +-
 .../kernel/syscalls/ipc/semctl/semctl04.c     |   2 +-
 .../kernel/syscalls/ipc/semctl/semctl05.c     |   2 +-
 .../kernel/syscalls/ipc/semctl/semctl08.c     |  52 +++
 testcases/kernel/syscalls/ipc/semget/Makefile |   5 +-
 .../kernel/syscalls/ipc/semget/semget01.c     |   4 +-
 .../kernel/syscalls/ipc/semget/semget02.c     |   4 +-
 .../kernel/syscalls/ipc/semget/semget03.c     |   4 +-
 .../kernel/syscalls/ipc/semget/semget05.c     |   2 +-
 .../kernel/syscalls/ipc/semget/semget06.c     |   4 +-
 testcases/kernel/syscalls/ipc/semop/Makefile  |   5 +-
 testcases/kernel/syscalls/ipc/semop/semop03.c |   2 +-
 testcases/kernel/syscalls/ipc/semop/semop04.c |   2 +-
 testcases/kernel/syscalls/ipc/semop/semop05.c |   2 +-
 testcases/kernel/syscalls/ipc/shmat/Makefile  |   5 +-
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/shmctl/Makefile |  10 +-
 .../kernel/syscalls/ipc/shmctl/shmctl02.c     |   2 +-
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     |   2 +-
 .../kernel/syscalls/ipc/shmctl/shmctl04.c     |   2 +-
 .../kernel/syscalls/ipc/shmctl/shmctl06.c     |  51 +++
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |   5 +-
 testcases/kernel/syscalls/ipc/shmdt/shmdt01.c |   2 +-
 testcases/kernel/syscalls/ipc/shmget/Makefile |   5 +-
 .../kernel/syscalls/ipc/shmget/shmget01.c     |   2 +-
 .../kernel/syscalls/ipc/shmget/shmget02.c     |   2 +-
 .../kernel/syscalls/ipc/shmget/shmget03.c     |   2 +-
 .../kernel/syscalls/ipc/shmget/shmget04.c     |   2 +-
 .../kernel/syscalls/ipc/shmget/shmget05.c     |   2 +-
 testcases/kernel/syscalls/kill/Makefile       |  19 +-
 testcases/kernel/syscalls/kill/kill07.c       |   2 +-
 testcases/kernel/syscalls/mremap/Makefile     |  19 +-
 73 files changed, 1124 insertions(+), 163 deletions(-)
 create mode 100644 include/ipcbuf.h
 rename {testcases/kernel/syscalls/ipc/lib => include}/ipcmsg.h (100%)
 rename {testcases/kernel/syscalls/ipc/lib => include}/ipcsem.h (100%)
 rename {testcases/kernel/syscalls/ipc/lib => include}/ipcshm.h (100%)
 rename {testcases/kernel/syscalls/ipc/lib => include}/libmsgctl.h (100%)
 rename {testcases/kernel/syscalls/ipc/libnewipc => include}/libnewipc.h (98%)
 create mode 100644 include/msgbuf.h
 create mode 100644 include/sembuf.h
 create mode 100644 include/shmbuf.h
 rename {testcases/kernel/syscalls/ipc/lib => libs/libltpipc}/Makefile (63%)
 rename {testcases/kernel/syscalls/ipc/lib => libs/libltpipc}/libipc.c (100%)
 rename {testcases/kernel/syscalls/ipc/lib => libs/libltpipc}/libmsgctl.c (100%)
 rename {testcases/kernel/syscalls/ipc/libnewipc => libs/libltpnewipc}/Makefile (63%)
 rename {testcases/kernel/syscalls/ipc/libnewipc => libs/libltpnewipc}/libnewipc.c (100%)
 delete mode 100644 testcases/kernel/syscalls/ipc/Makefile.inc
 delete mode 100644 testcases/kernel/syscalls/ipc/Makefile2.inc
 create mode 100755 testcases/kernel/syscalls/ipc/msgctl/msgctl05
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
 create mode 100644 testcases/kernel/syscalls/ipc/semctl/semctl08.c
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c

-- 
2.25.0.rc1.19.g042ed3e048af

