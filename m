From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 16 Jul 2021 18:22:52 +0800
Subject: [LTP] [PATCH 0/5 v2] epoll_pwait2: Add test for epoll_pwait2
In-Reply-To: <20210628080424.245911-3-xieziyao@huawei.com>
References: <20210628080424.245911-3-xieziyao@huawei.com>
Message-ID: <20210716102257.20882-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1->v2:
1. Add the prototype for epoll_pwait and epoll_pwait2 into include/lapi/epoll.h.
2. Add test variants to switch between epoll_pwait and epoll_pwait2 for epoll_pwait.

Xie Ziyao (5):
  lapi/syscalls: Add syscall number for epoll_pwait2
  lapi: Add the prototype for epoll_pwait and epoll_pwait2
  epoll_pwait: Add test variants for epoll_pwait
  epoll_pwait: Add test for epoll_pwait02
  epoll_pwait: Add test for epoll_pwait03

 configure.ac                                  |  1 +
 include/lapi/epoll.h                          | 37 +++++++++-
 include/lapi/syscalls/aarch64.in              |  1 +
 include/lapi/syscalls/arc.in                  |  1 +
 include/lapi/syscalls/arm.in                  |  1 +
 include/lapi/syscalls/hppa.in                 |  3 +-
 include/lapi/syscalls/i386.in                 |  1 +
 include/lapi/syscalls/ia64.in                 |  1 +
 include/lapi/syscalls/powerpc.in              |  1 +
 include/lapi/syscalls/powerpc64.in            |  1 +
 include/lapi/syscalls/s390.in                 |  1 +
 include/lapi/syscalls/s390x.in                |  1 +
 include/lapi/syscalls/sh.in                   |  1 +
 include/lapi/syscalls/sparc.in                |  1 +
 include/lapi/syscalls/sparc64.in              |  1 +
 include/lapi/syscalls/x86_64.in               |  1 +
 runtest/syscalls                              |  2 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  4 +-
 .../syscalls/epoll_pwait/epoll_pwait02.c      | 65 ++++++++++++++++
 .../syscalls/epoll_pwait/epoll_pwait03.c      | 74 +++++++++++++++++++
 .../syscalls/epoll_pwait/epoll_pwait_var.h    | 43 +++++++++++
 21 files changed, 237 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h

--
2.17.1

