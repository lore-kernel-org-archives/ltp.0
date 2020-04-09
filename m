From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:44:46 +0800
Subject: [LTP] [PATCH v2 00/10] add loop ioctl test
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1586429086-22975-11-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a set of test for the loop ioctl.

v1->v2:
1. remove linux/loop.h detection
2. use TST_RETRY_FUNC instead of safe_set_status
3. modify makefile
4. free tmpdir
5. use BLKSSZGET ioctl() to get logical block size

Yang Xu (10):
  lapi/loop.h: Add fallback for loop ioctl and flag
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

 include/lapi/loop.h                           |  35 ++++
 runtest/syscalls                              |  10 +-
 testcases/kernel/syscalls/ioctl/.gitignore    |   8 +
 testcases/kernel/syscalls/ioctl/Makefile      |   5 +
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 140 ++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop02.c      | 150 ++++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop03.c      |  76 +++++++++
 .../kernel/syscalls/ioctl/ioctl_loop04.c      |  97 +++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 125 +++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop06.c      |  90 +++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop07.c      |  85 ++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop08.c      |  96 +++++++++++
 .../syscalls/ioctl/ioctl_loop_support.c       |  40 +++++
 .../syscalls/ioctl/ioctl_loop_support.h       |  12 ++
 14 files changed, 968 insertions(+), 1 deletion(-)
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



