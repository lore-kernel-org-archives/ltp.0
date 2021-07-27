From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 27 Jul 2021 20:45:04 +0800
Subject: [LTP] [PATCH 0/3] epoll_pwait: Add test variants for epoll_pwait2
 in epoll_pwait01
Message-ID: <20210727124507.28356-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (3):
  tst_process_state: Add tst_process_state_wait2 to newlib
  lapi: Add epoll_pwait_supported() and epoll_pwait2_supported() check
  epoll_pwait: Add test variants for epoll_pwait2 in epoll_pwait01

 include/lapi/epoll.h                          |  22 +-
 include/tst_process_state.h                   |  18 +-
 .../syscalls/epoll_pwait/epoll_pwait01.c      | 234 ++++++------------
 3 files changed, 108 insertions(+), 166 deletions(-)

--
2.17.1

