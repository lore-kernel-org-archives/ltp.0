From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 2 Apr 2020 23:06:20 +0800
Subject: [LTP] [PATCH v1 00/10] add loop ioctl test
Message-ID: <1585839990-19923-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a set of test for the loop ioctl.

Yang Xu (10):
  lapi: Add a configure check and fallback for loop ioctl and flag
  syscalls/ioctl:add common c file for loop ioctl
  syscalls/ioctl_loop01: Add LO_FLAGS_AUTOCLEAR and LO_FLAGS_PARTSCAN
    test
  syscalls/ioctl_loop02: Add LO_FLAGS_READ_ONLY and LOOP_CHANGE_FD test
  syscalls/ioctl_loop03: Add LOOP_CHANGE_FD test with WR mode
  syscalls/ioctl_loop04: Add LOOP_SET_CAPACITY ioctl test
  syscalls/ioctl_loop05: Add LOOP_SET_DIRECT_IO ioctl test
  syscalls/ioctl_loop06: Add LOOP_SET_BLOCK_SIZE error test
  syscalls/ioctl_loop07: Add dio with logic block size error test
  syscalls/ioctl_loop08: Add LOOP_SET/GET_STATUS64 sizelimit field test

 configure.ac                                  |   1 +
 include/lapi/loop.h                           |  35 +++++
 runtest/syscalls                              |  10 +-
 testcases/kernel/syscalls/ioctl/.gitignore    |   8 +
 testcases/kernel/syscalls/ioctl/Makefile      |   3 +
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 127 +++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop02.c      | 148 ++++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop03.c      |  76 +++++++++
 .../kernel/syscalls/ioctl/ioctl_loop04.c      |  97 ++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 120 ++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop06.c      |  90 +++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop07.c      |  85 ++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop08.c      |  96 ++++++++++++
 .../syscalls/ioctl/ioctl_loop_support.c       |  74 +++++++++
 .../syscalls/ioctl/ioctl_loop_support.h       |  14 ++
 15 files changed, 983 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/loop.h
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop01.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop02.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop03.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop04.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop05.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop06.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop07.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop08.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop_support.h

-- 
2.23.0



