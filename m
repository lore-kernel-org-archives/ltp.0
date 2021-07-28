From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 28 Jul 2021 17:29:16 +0800
Subject: [LTP] [PATCH 0/2 v2] epoll_pwait: Add test variants for
 epoll_pwait2 in epoll_pwait01
Message-ID: <20210728092918.202639-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1->v2:
1. Remove testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h.
2. Switch tst_process_state_wait2() to TST_PROCESS_STATE_WAIT().

Xie Ziyao (2):
  lapi: Add epoll_pwait_supported() and epoll_pwait2_supported() check
  epoll_pwait: Add test variants for epoll_pwait2 in epoll_pwait01

 include/lapi/epoll.h                          |  22 +-
 .../kernel/syscalls/epoll_pwait/epoll_pwait.h |  36 ---
 .../syscalls/epoll_pwait/epoll_pwait01.c      | 233 ++++++------------
 3 files changed, 98 insertions(+), 193 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h

--
2.17.1

