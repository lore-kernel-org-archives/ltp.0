From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 15:50:18 +0530
Subject: [LTP] [PATCH V2 0/6] syscalls: Add tests to verify the _time_high
 fields
Message-ID: <cover.1592302358.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This patchset adds a new tests to three syscalls to verify that the
extended fields, _time_high, are cleared by the kernel. This was
suggested by Arnd.

V2:
- Separate out structure definitions to separate patches.
- Drop first two patches from V1 as they are already applied.
- Minor makefile fixes.

Viresh Kumar (6):
  include: Add declaration of struct semid64_ds
  syscalls: semctl: Add new test to verify the _time_high fields
  include: Add declaration of struct shmid64_ds
  syscalls: shmctl: Add new test to verify the _time_high fields
  include: Add declaration of struct msqid64_ds
  syscalls: msgctl: Add new test to verify the _time_high fields

 configure.ac                                  |   3 +
 include/lapi/msgbuf.h                         | 306 ++++++++++++++++++
 include/lapi/sembuf.h                         | 234 ++++++++++++++
 include/lapi/shmbuf.h                         | 273 ++++++++++++++++
 runtest/syscalls                              |   3 +
 runtest/syscalls-ipc                          |   3 +
 .../kernel/syscalls/ipc/msgctl/.gitignore     |   1 +
 .../kernel/syscalls/ipc/msgctl/msgctl05.c     |  48 +++
 .../kernel/syscalls/ipc/semctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/semctl/Makefile |   5 +-
 .../kernel/syscalls/ipc/semctl/semctl08.c     |  52 +++
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/shmctl/Makefile |   5 +-
 .../kernel/syscalls/ipc/shmctl/shmctl06.c     |  51 +++
 14 files changed, 983 insertions(+), 3 deletions(-)
 create mode 100644 include/lapi/msgbuf.h
 create mode 100644 include/lapi/sembuf.h
 create mode 100644 include/lapi/shmbuf.h
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
 create mode 100644 testcases/kernel/syscalls/ipc/semctl/semctl08.c
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c

-- 
2.25.0.rc1.19.g042ed3e048af

